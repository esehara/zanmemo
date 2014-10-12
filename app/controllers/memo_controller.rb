# -*- coding: utf-8 -*-
class MemoController < ApplicationController

  def show
    @memo = Memo.find_by!(trace_id: params[:trace_id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    if user_signed_in?
      @memo = current_user.memos.build(post_params)
      @memo.save
      redirect_to "/users/#{current_user.trace_id}"
    else
      raise redirect_to root_path, alert: "ログインしてください"
    end
  end

  def post_params
    params.require(:memo).permit(:content)
  end
end
