class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :to_do_list
  load_and_authorize_resource :through => :to_do_list

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

  private

  def assignment_params
    params.require(:assignment).permit(:name, :description)
  end
end
