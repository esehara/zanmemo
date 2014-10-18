class UsersController < ApplicationController

  def set_add_title
    @add_title = "user :: #{@user.trace_id}"
  end

  def feed
    @user = User.find_by!(trace_id: params[:trace_id])
    @memo = @user.memos[0]
    respond_to do |format|
      format.rss { render :layout => false}
    end
  end
  
  def show
    if user_signed_in?
      @memo = current_user.memos.build
    end
    @user = User.find_by!(trace_id: params[:trace_id])
    set_add_title
    respond_to do |format|
      format.html
      format.json
    end
  end
end
