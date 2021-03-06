module CapybaraHelper
  def self.included(receiver)
    receiver.let!(:current_user) do
      create(:user, email: "user@test.com.br")
    end
  end

  def sign_up
    visit root_path

    click_link "Nova conta"

    fill_in "Email", with: "test@test.com"
    fill_in "user[password]", with: "12345678"
    fill_in "Confirme sua senha", with: "12345678"

    click_button "Criar conta"
  end

  def sign_in
    if RSpec.current_example.metadata[:js]
      visit new_user_session_path

      fill_in "Email", with: current_user.email
      fill_in "Senha", with: current_user.password

      click_button "Log in"
    else
      page.set_rack_session(
        "warden.user.user.key" => User.serialize_into_session(current_user).unshift("User")
      )

      visit user_path(current_user)
    end
  end

  def sign_out
    within '#navbar .navbar-right' do
      click_link current_user.email

      within ".dropdown-menu" do
        click_link "Sair"
      end
    end
  end

  def access_nav_menu(paths)
    path_1, path_2  = paths.split(" > ")

    within '#navbar .navbar-left' do
      click_link path_1

      if path_2 
        within ".dropdown-menu" do
          click_link path_2
        end
      end
    end
  end
end
