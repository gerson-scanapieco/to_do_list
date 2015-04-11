class FavoriteToDoListsController < ApplicationController
  before_action :authenticate_user!

  def create    
    @favorite_to_do_list = 
      current_user.favorite_to_do_lists.build(to_do_list_id: favorite_to_do_list_params[:to_do_list_id] )

    authorize! :create, @favorite_to_do_list

    respond_to do |format|
      if @favorite_to_do_list.save
        format.json
      end
    end
  end

  def destroy
    @favorite_to_do_list = FavoriteToDoList.find(params[:id])

    authorize! :destroy, @favorite_to_do_list

    respond_to do |format|
      if @favorite_to_do_list.destroy
        format.json { render status: :ok }
      end
    end
  end

  private

  def favorite_to_do_list_params
    params.require(:favorite_to_do_list).permit(:to_do_list_id)
  end
end
