class UsersController < ApplicationController
  def show
    @user = User.find_by!(trace_id: params[:trace_id])
    respond_to do |format|
      format.html
      format.json
    end
  end
end
