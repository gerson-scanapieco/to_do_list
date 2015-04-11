class ToDoListsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [ :public, :index ]

  def index
    @to_do_lists = current_user.to_do_lists
  end

  def show
    @favorite = @to_do_list.favorite_id(current_user)
  end

  def new
  end

  def create
    list = current_user.to_do_lists.build(to_do_list_params)

    if list.save
      redirect_to to_do_list_path(list), notice: "Lista criada com sucesso."
    else
      flash.now[:alert] = "Lista não pôde ser criada."
      render 'new'
    end
  end

  def edit
  end

  def update
    @to_do_list = ToDoList.find(params[:id])

    respond_to do |format|
      if @to_do_list.update_attributes(to_do_list_params)
        format.html { redirect_to to_do_list_path(@to_do_list), notice: "Alterações salvas com sucesso." }
        format.js
      else
        format.html { flash.now[:alert] = "Lista não pôde ser editada."; render 'edit' }
        format.js
      end
    end
  end

  def destroy
    list = ToDoList.find(params[:id])

    if list.destroy
      redirect_to user_to_do_lists_path(current_user), notice: "Lista apagada com sucesso."
    else
      flash.now[:alert] = "Lista não pôde ser apagada."
      render 'index'
    end
  end

  def assignment_form
    @to_do_list = ToDoList.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def public
    @to_do_lists = ToDoList.includes(:user).public_lists
  end

  private

  def to_do_list_params
    params.require(:to_do_list).permit(:name, :list_type, assignments_attributes: [:id, :name, :description, :_destroy] )
  end
end
