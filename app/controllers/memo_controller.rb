# -*- coding: utf-8 -*-
class MemoController < ApplicationController
  
  def set_memo_title
    title = @memo.content.split("\n")[0]
    if title.length > 40
      title = title.slice(0..60) + "..."
    end
    @add_title = title
  end
  
  def show
    @memo = Memo.find_by!(trace_id: params[:trace_id])
    set_memo_title
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

  def update
    @memo = current_user.memos.find_by(trace_id: params[:trace_id])
    if @memo.update(post_params)
      redirect_to memo_path(@memo.trace_id), notice: "更新しました"
    else
      render :edit
    end
  end
  
  def delete
    # TODO: ここもdryにして、:trace_idが入ってきたらインスタンス変数にバインドするべき
    @memo = current_user.memos.find_by(trace_id: params[:trace_id])
    @memo.destroy!
    redirect_to user_show_path(current_user.trace_id), notice: "無事削除されました"
  end
  
  def post_params
    params.require(:memo).permit(:content)
  end
end
