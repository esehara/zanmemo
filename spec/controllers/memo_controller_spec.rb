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

  describe 'POST memo#create' do
    context 'ログインしていないとき' do
      before do
        post :create, {:content => attributes_for(:memo)}
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしているとき' do
      before do
        @user = create :user
        sign_in @user
        post :create, {:memo => {:content => "ほげほげ"}}
      end

      it 'トップページにリダイレクトしない' do
        expect(response).not_to redirect_to(root_path)
      end
      
      it 'メモが一つモデルとして作られている' do
        expect(@user.reload.memos.length).to be > 0
      end
      
      it '自分のURLにリダイレクトする' do
        expect(response).to redirect_to(user_show_path(:trace_id => @user.trace_id))
      end
    end
  end
  
  describe 'GET memo#edit' do 
    context 'ログインしていないとき' do
      before do
        memo = create :memo
        get :edit, :trace_id => memo.trace_id
      end
      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end

    context '違うユーザーが編集しようとするとき' do
      before do
        user = create :user
        memo = create :memo
        sign_in user
        get :edit, :trace_id => memo.trace_id
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end
    
  end
end
