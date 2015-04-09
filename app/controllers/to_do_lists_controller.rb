class ToDoListsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
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

    if @to_do_list.update_attributes(to_do_list_params)
      redirect_to to_do_list_path(@to_do_list), notice: "Alterações salvas com sucesso."
    else
      flash.now[:alert] = "Lista não pôde ser editada."
      render 'edit'
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

  private

  def to_do_list_params
    params.require(:to_do_list).permit(:name, :list_type)
  end
end
