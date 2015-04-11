require 'rails_helper'

RSpec.describe FavoriteToDoListsController, type: :controller do
  login_user

  describe "GET #index" do
    it "renders the template :index" do
      get :index, user_id: @user.id

      expect(response).to render_template :index
    end

    it "assigns to @favorites the correct value" do
      another_user = create(:user)
      to_do_list = create(:to_do_list, :public, user: another_user)
      favorite = create(:favorite_to_do_list, to_do_list: to_do_list, user: @user)

      get :index, user_id: @user.id

      expect(assigns(:favorites)).to eq([favorite])
    end
  end

  describe "POST #create" do
    render_views

    let!(:another_user) { create(:user, :with_public_lists) }
    let!(:another_user_public_list) { another_user.to_do_lists.first }

    it "returns a JSON response with the ID of the created FavoriteToDoList record" do      
      post :create, { format: "json", favorite_to_do_list: { to_do_list_id: another_user_public_list.id } }

      expect(JSON.parse(response.body)["favorite_to_do_list"]["id"]).to_not be_nil
    end

    it "creates a FavoriteToDoList record" do
      expect{
        post :create, { format: "json", favorite_to_do_list: { to_do_list_id: another_user_public_list.id } }
      }.to change{ FavoriteToDoList.count }.by(1)
    end
  end

  describe "DELETE #destroy" do
    render_views

    let!(:another_user) { create(:user, :with_public_lists) }
    let!(:another_user_public_list) { another_user.to_do_lists.first }

    let!(:favorite_to_do_list) { 
      create(:favorite_to_do_list, user: @user, to_do_list: another_user_public_list)
    }

    it "returns a response with status 200" do
      delete :destroy, { format: "json", id: favorite_to_do_list.id }

      expect(response.status).to eq 200
    end

    it "destroys a FavoriteToDoList record" do
      expect {
        delete :destroy, { format: "json", id: favorite_to_do_list.id }
      }.to change{ FavoriteToDoList.count }.by(-1)
    end
  end
end
