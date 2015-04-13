require 'rails_helper'

feature "ToDoLists" do
  background do
    sign_in
  end

  context "displaying to_do_lists" do
    let!(:public_list) { create(:to_do_list, :public, user: current_user) }
    let!(:private_list) { create(:to_do_list, user: current_user) }
    let!(:another_user) { create(:user) }
    let!(:another_user_public_list) { create(:to_do_list, :public, user: another_user) }
    let!(:another_user_private_list) { create(:to_do_list, user: another_user) }

    scenario "displaying current user's to_do_lists" do
      access_nav_menu "Listas > Minhas listas"

      expect(page).to have_content public_list.name
      expect(page).to have_content private_list.name

      expect(page).to have_content "Criar lista"
    end

    scenario "displaying another user's to_do_lists" do
      visit user_to_do_lists_path(another_user)

      expect(page).to have_content another_user_public_list.name

      expect(page).to_not have_content another_user_private_list.name

      expect(page).to_not have_content "Criar lista"
    end
  end

  scenario "create a new private to_do_list" do
    access_nav_menu "Listas > Minhas listas"

    click_link "Criar lista"

    fill_in "Nome", with: "nova lista"

    click_button "Salvar"

    expect(page).to have_content "Lista criada com sucesso."
  end

  scenario "create a new public to_do_list" do
    access_nav_menu "Listas > Minhas listas"

    click_link "Criar lista"

    fill_in "Nome", with: "nova lista"
    select "Pública", from: "Tipo"

    click_button "Salvar"

    expect(page).to have_content "Lista criada com sucesso."
  end

  scenario "edit a to_do_list" do
    list = create(:to_do_list, user: current_user)

    access_nav_menu "Listas > Minhas listas"

    click_link list.name

    click_link "Editar lista"

    fill_in "Nome", with: "nome editado"

    click_button "Salvar"

    expect(page).to have_content "Alterações salvas com sucesso"
    expect(page).to have_content "nome editado"
  end

  scenario "delete a to_do_list" do
    list = create(:to_do_list, user: current_user)

    access_nav_menu "Listas > Minhas listas"

    click_link list.name

    click_link "Apagar lista"

    expect(page).to have_content "Lista apagada com sucesso."
  end
end
