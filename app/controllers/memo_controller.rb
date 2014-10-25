# -*- coding: utf-8 -*-
class MemoController < ApplicationController
  
  def set_memo_title
    @add_title = @memo.title
  end
  
  def show
    @memo = Memo.find_by(trace_id: params[:trace_id])
    if @memo
      set_memo_title
      return respond_to do |format|
        format.html
        format.json
      end
    end
    return render :nothing => true, :status => :not_found
 end

  def create
    if user_signed_in?
      @memo = current_user.memos.build(post_params)
      @memo.save
      redirect_to "/users/#{current_user.trace_id}"
    else
      redirect_to root_path, alert: "ログインしてください"
    end
  end

  def edit
    if user_signed_in?
      @memo = current_user.memos.find_by(trace_id: params[:trace_id])
      if !@memo
        redirect_to root_path, alert: "違うユーザーのメモは編集できません"
      end
    else
      redirect_to root_path, alert: "ログインしてください"
    end
  end

  def valid_update
    if @memo.update(post_params)
      redirect_to memo_path(@memo.trace_id), notice: "更新しました"
    else
      render :edit
    end  
  end
  
  def update
    if user_signed_in?
      @memo = current_user.memos.find_by(trace_id: params[:trace_id])
      if @memo
        return valid_update
      end
    end
    return render :nothing => true, :status => :unauthorized
  end
  
  def delete
    if user_signed_in? 
      @memo = current_user.memos.find_by(trace_id: params[:trace_id])
      if @memo
        @memo.destroy!
        return redirect_to user_show_path(current_user.trace_id), notice: "無事削除されました" 
      end
    end
    return render :nothing => true, :status => :unauthorized
 end
  
  def post_params
    params.require(:memo).permit(:content)
  end
end
