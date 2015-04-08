module CapybaraHelper
  def self.included(receiver)
    receiver.let!(:current_user) do
      create(:user, email: "user@test.com.br")
    end
  end

  def sign_up
    visit root_path

    click_link "Sign up"

    fill_in "Email", with: "test@test.com"
    fill_in "user[password]", with: "12345678"
    fill_in "Password confirmation", with: "12345678"

    click_button "Sign up"
  end

  def sign_in
    if RSpec.current_example.metadata[:js]
      visit new_user_session_path

      fill_in "Email", with: current_user.email
      fill_in "Password", with: current_user.password

      click_button "Log in"
    else
      page.set_rack_session(
        "warden.user.user.key" => User.serialize_into_session(current_user).unshift("User")
      )

      visit user_path(current_user)

      # TODO
      # Apos implementar users#show, adicionar um 'expect(page).to have_content' aqui
      # para testar se esta tudo ok
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
end
