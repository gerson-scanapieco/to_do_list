require 'rails_helper'

RSpec.describe FavoriteToDoListsController, type: :controller do
  login_user

  describe "POST #create" do
    render_views

    let!(:another_user) { create(:user, :with_public_lists) }
    let!(:another_user_public_list) { another_user.to_do_lists.first }

    it "returns a JSON response with the ID of the created FavoriteToDoList record" do      
      post :create, { format: "json", favorite_to_do_list: { to_do_list_id: another_user_public_list.id } }

      expect(JSON.parse(response.body)["favorite_to_do_list"]["id"]).to eq 1
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
