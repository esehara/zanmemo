class UsersController < ApplicationController
  def show
    if user_signed_in?
      @memo = current_user.memos.build
    end
    @user = User.find_by!(trace_id: params[:trace_id])
    respond_to do |format|
      format.html
      format.json
    end
  end
end
