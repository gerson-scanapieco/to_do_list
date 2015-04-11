require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  login_user

  let!(:to_do_list) { create(:to_do_list, user: @user) }

  describe "GET #new" do
    it "renders the the template :new" do
      xhr :get, :new, { to_do_list_id: to_do_list.id }

      expect(response).to render_template :new
    end

    it "sets a new Assignment in @assignment" do
      xhr :get, :new, { to_do_list_id: to_do_list.id }

      expect(assigns(:assignment)).to be_a_new(Assignment)
    end
  end

  describe "POST #create" do
    it "creates a new Assignment record" do
      expect{
        xhr :post, :create, { to_do_list_id: to_do_list.id, assignment: attributes_for(:assignment) }
      }.to change{ Assignment.count }.by(1)
    end

    it "renders the :create template" do
      xhr :post, :create, { to_do_list_id: to_do_list.id, assignment: attributes_for(:assignment) }

      expect(response).to render_template :create
    end
  end

  describe "PUT #update" do
    let(:assignment) { create(:assignment, to_do_list: to_do_list) }

    it "sets the correct Assignment on @assignment" do
      xhr :put, :update, { id: assignment.id, assignment: { name: "nome editado" } }

      expect(assigns(:assignment)).to eq Assignment.find(assignment.id)
    end

    it "updates @assignment with the correct values" do
      xhr :put, :update, { id: assignment.id, assignment: { name: "nome editado" } }

      assignment.reload

      expect(assignment.name).to eq "nome editado"
    end

    it "renders the template :update" do
      xhr :put, :update, { id: assignment.id, assignment: { name: "nome editado" } }

      expect(response).to render_template :update
    end
  end
end
