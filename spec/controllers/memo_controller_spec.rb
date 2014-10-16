# -*- coding: utf-8 -*-
require 'rails_helper'
require 'memo_controller'
RSpec.describe MemoController, :type => :controller do
  describe 'GET memo#show' do
     context 'メモを閲覧しようとしたとき' do
      before do
        memo = create :memo
        get :show, :trace_id => memo.trace_id
      end
      it 'メモを閲覧できる' do
        expect(response.status).to eq(200)
      end
    end
  end
  
  describe 'GET memo#edit' do 
    context 'メモを編集しようとしたとき' do
      before do
        memo = create :memo
        get :edit, :trace_id => memo.trace_id
      end
      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
