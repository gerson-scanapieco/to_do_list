require 'rails_helper'

feature "sign_up" do
  scenario "sign_up from UI" do
    sign_up

    expect(page).to have_content "Bem vindo! Você realizou seu registro com sucesso."
  end
end