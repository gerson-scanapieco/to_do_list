require 'rails_helper'

feature "sign_out" do
  background do
    sign_in
  end

  scenario "sign_out from UI" do
    sign_out

    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end