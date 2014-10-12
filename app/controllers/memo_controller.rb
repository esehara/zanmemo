class MemoController < ApplicationController
  def show
    @memo = Memo.find_by!(trace_id: params[:trace_id])
    respond_to do |format|
      format.html
      format.json
    end
  end
end
