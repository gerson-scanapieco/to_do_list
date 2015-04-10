require 'rails_helper'

feature "PublicToDoLists" do
  background do
    sign_in
  end

  let!(:public_list) { create(:to_do_list, :public, user: current_user) }
  let!(:private_list) { create(:to_do_list, user: current_user) }

  let!(:another_user) { create(:user, :with_lists) }
  let!(:another_user_private_list) { another_user.to_do_lists.first }
  let!(:another_user_public_list) { create(:to_do_list, :public, user: another_user) }

  scenario "displaying public lists" do
    access_nav_menu "Listas > Listas públicas"

    expect(page).to have_content public_list.name
    expect(page).to have_content another_user_public_list.name
  end

  scenario "does not display private lists" do
    access_nav_menu "Listas > Listas públicas"

    expect(page).to_not have_content private_list.name
    expect(page).to_not have_content another_user_private_list.name
  end
end
