require 'rails_helper'

RSpec.describe ToDoListsController, type: :controller do
  login_user

  let!(:to_do_list) { create(:to_do_list, user: @user) }

  describe "GET #index" do
    it "renders the template :index" do
      get :index, { user_id: @user.id }

      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "renders the template :show" do
      get :show, { id: to_do_list.id }

      expect(response).to render_template :show
    end

    it "sets the correct ToDoList in @to_do_list" do
      get :show, { id: to_do_list.id }

      expect(assigns(:to_do_list)).to eq(to_do_list)
    end
  end

  describe "GET #new" do
    it "renders the the template :new" do
      get :new, { user_id: @user.id }

      expect(response).to render_template :new
    end

    it "sets a new ToDoList in @to_do_list" do
      get :new, { user_id: @user.id }

      expect(assigns(:to_do_list)).to be_a_new(ToDoList)
    end
  end

  describe "GET #edit" do
    it "renders the template :edit" do
      get :edit, { id: to_do_list.id }

      expect(response).to render_template :edit
    end

    it "sets the correct ToDoList in @to_do_list" do
      get :edit, { id: to_do_list.id }

      expect(assigns(:to_do_list)).to eq(to_do_list)
    end
  end

  describe "POST #create" do
    context "when sucessfully creating a ToDoList" do
      it "creates a new ToDoList" do
        expect{
          post :create, { user_id: @user.id, to_do_list: attributes_for(:to_do_list) }
        }.to change{ ToDoList.count }.by(1)
      end

      it "sets a success message" do
        post :create, { user_id: @user.id, to_do_list: attributes_for(:to_do_list) }

        expect(flash.notice).to eq "Lista criada com sucesso."
      end

      it "redirects to :show template" do
        post :create, { user_id: @user.id, to_do_list: attributes_for(:to_do_list) }

        expect(response).to redirect_to(to_do_list_path(ToDoList.last.id))
      end
    end

    context "when unsuccessfull operation" do
      it "does not create a new ToDoList" do
        expect{
          post :create, { user_id: @user.id, to_do_list: { name: "" } }
        }.to_not change{ ToDoList.count }
      end

      it "sets an error message" do
        post :create, { user_id: @user.id, to_do_list: { name: "" } }

        expect(flash.alert).to_not be_nil
      end

      it "renders the :new template" do
        post :create, { user_id: @user.id, to_do_list: { name: "" } }

        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    context "when successfull operation" do
      it "sets the correct ToDoList in @to_do_list" do
        put :update, { id: to_do_list.id, to_do_list: { name: "nome editado" } }

        expect(assigns(:to_do_list)).to eq(to_do_list)
      end

      it "updates the list with the correct information" do
        put :update, { id: to_do_list.id, to_do_list: { name: "nome editado" } }

        to_do_list.reload

        expect(to_do_list.name).to eq "nome editado"
      end

      it "sets a success message" do
        put :update, { id: to_do_list.id, to_do_list: { name: "nome editado" } }

        expect(flash.notice).to eq "Alterações salvas com sucesso."
      end

      it "redirects to :show" do
        put :update, { id: to_do_list.id, to_do_list: { name: "nome editado" } }

        expect(response).to redirect_to to_do_list_path(to_do_list)
      end
    end

    context "when unsuccessfull operation" do
      it "does not update the list with the wrong information" do
        put :update, { id: to_do_list.id, to_do_list: { name: "" } }

        to_do_list.reload

        expect(to_do_list.name).to eq to_do_list.name
      end

      it "sets an error message" do
        put :update, { id: to_do_list.id, to_do_list: { name: "" } }

        expect(flash.alert).to_not be_nil
      end

      it "renders the :edit template" do
        put :update, { id: to_do_list.id, to_do_list: { name: "" } }

        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "when successfull operation" do
      it "deletes the ToDoList" do
        expect{
          delete :destroy, { id: to_do_list.id }
        }.to change{ ToDoList.count }.by(-1)
      end

      it "sets a success message" do
        delete :destroy, { id: to_do_list.id }

        expect(flash.notice).to eq "Lista apagada com sucesso."
      end

      it "redirects to :index" do
        delete :destroy, { id: to_do_list.id }

        expect(response).to redirect_to(user_to_do_lists_path(@user))
      end
    end
  end

  describe "GET #public" do
    it "displays the template :public" do
      get :public

      expect(response).to render_template :public
    end
  end
end
