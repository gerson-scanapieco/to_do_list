require 'rails_helper'

feature "Assignments" do
  background do
    sign_in
  end

  let!(:to_do_list) { create(:to_do_list, user: current_user ) }

  scenario "create a new Assignment", js: true do
    access_nav_menu "Listas > Minhas listas"

    click_link to_do_list.name

    expect(page).to have_content "Nenhuma tarefa encontrada."

    click_link "Adicionar tarefa"

    within ".new-assignment" do
      fill_in "Nome", with: "nova tarefa"
      fill_in "Descrição", with: "descricao tarefa"

      click_button "Add"
    end

    expect(page).to_not have_content "Nenhuma tarefa encontrada."
    expect(page).to have_content "nova tarefa"
    expect(page).to have_content "descricao tarefa"
  end

  scenario "edit an Assignment", js: true do
    assignment = create(:assignment, to_do_list: to_do_list) 

    access_nav_menu "Listas > Minhas listas"

    click_link to_do_list.name

    sleep 1

    click_button "edit-assignment"

    sleep 1

    fill_in "edit-assignment-name", with: "nome_editado"
    fill_in "edit-assignment-description", with: "descricao_editado"

    click_button "update-assignment"

    expect(page).to_not have_button "update-assignment"
    expect(page).to_not have_button "cancel-update-assignment"

    within ".assignment-name" do
      expect(page).to have_content "nome_editado"
    end

    within ".assignment-description" do
      expect(page).to have_content "descricao"
    end
  end

  scenario "delete an Assignment", js: true do
    assignment = create(:assignment, to_do_list: to_do_list) 

    access_nav_menu "Listas > Minhas listas"

    click_link to_do_list.name

    sleep 1

    click_button "remove-assignment"

    sleep 1

    expect(page).to_not have_content assignment.name
    expect(page).to_not have_content assignment.description

    expect(page).to have_content "Nenhuma tarefa encontrada."
  end
end
