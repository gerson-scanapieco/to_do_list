require 'rails_helper'

feature "FavoriteToDoList" do
  background do
    sign_in
  end

  let!(:another_user) { create(:user, :with_public_lists) }
  let!(:another_user_public_list) { another_user.to_do_lists.first }

  scenario "View all favorite to_do_lists", js: true do
    favorite = create(:favorite_to_do_list, user: current_user, to_do_list: another_user_public_list)

    access_nav_menu "Favoritos"

    expect(page).to have_content another_user_public_list.name
  end 

  scenario "Add ToDoList to favorites", js: true do
    access_nav_menu "Listas > Listas públicas"

    click_link another_user_public_list.name
    sleep 1

    expect(page).to have_css "#favorite-button.btn-default"

    click_button "favorite-button"
    sleep 1

    expect(page).to have_css "#favorite-button.btn-warning"
  end

  scenario "Remove ToDoList from favorites", js: true do
    favorite = create(:favorite_to_do_list, user: current_user, to_do_list: another_user_public_list)

    access_nav_menu "Listas > Listas públicas"

    click_link another_user_public_list.name
    sleep 1

    expect(page).to have_css "#favorite-button.btn-warning"

    click_button "favorite-button"

    expect(page).to have_css "#favorite-button.btn-default"
  end  
end
