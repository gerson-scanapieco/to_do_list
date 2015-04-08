require 'rails_helper'

# Testa o metodo sign_in do CapybaraHelper
feature "sign_in" do
  scenario "signed_in from UI", js: true do
    sign_in

    expect(page).to have_content "Login efetuado com sucesso."
  end

  scenario "signed_in from rack_session" do
    sign_in
  end
end