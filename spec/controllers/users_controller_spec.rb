require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  describe "#update" do
    context "successfull update" do
      before(:each) do
        put :update, { id: @user.id, user: { name: "new_name" } }
      end

      it "updates the current user with the given information" do        
        @user.reload  
        expect(@user.name).to eq("new_name")
      end

      it "redirects to :edit" do
        expect(response).to redirect_to edit_user_path(@user)
      end

      it "sets a success message" do
        expect(flash.notice).to eq "Alterações salvas com sucesso" 
      end
    end

    context "unsuccessfull update" do
      before(:each) do
        put :update, { id: @user.id, user: { email: "" } }
      end

      it "renders :edit view" do
        expect(response).to render_template :edit
      end
    end
  end
end
