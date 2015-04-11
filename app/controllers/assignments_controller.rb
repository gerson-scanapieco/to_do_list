class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :to_do_list
  load_and_authorize_resource :through => :to_do_list

  skip_load_resource only: [ :update, :destroy ]

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    if @assignment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    authorize! :update, @assignment 

    if @assignment.update_attributes(assignment_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    authorize! :update, @assignment 

    if @assignment.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :description)
  end
end
