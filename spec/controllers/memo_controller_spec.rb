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

    context 'メモの作成者が編集ページを開くとき' do
      before do
        memo = create :memo
        sign_in memo.user
        get :edit, :trace_id => memo.trace_id
      end

      it '200 response OKが帰ってくる' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT memo#update" do
    context 'ユーザーがログインしていないときにrequireする' do
      before do
        memo = create :memo
        patch :update, :trace_id => memo.trace_id
      end

      it '401 Status Errorが帰ってくる' do
        expect(response.status).to eq(401)
      end
    end

    context '違うユーザーがpatchしようとしたとき' do
      before do
        memo = create :memo
        user = create :user
        sign_in user
        patch :update, :trace_id => memo.trace_id, :memo => attributes_for(:memo)
      end

      it '401 Status Errorが返ってくる' do
        expect(response.status).to eq(401)
      end
    end

    context 'そのメモの作成者が更新しようとした場合' do
      before do
        @memo = create :memo
        @attribute = attributes_for(:memo)
        sign_in @memo.user
      end

      it '更新元と更新後の文章が違うことを確認' do 
        expect(@memo.content).not_to eq(@attribute[:content])
      end
      
      it 'メモの内容が更新されている' do
        patch :update, :trace_id => @memo.trace_id, :memo => @attribute
        expect(@memo.reload.content).to eq(@attribute[:content])
      end
    end
  end

  describe 'DELETE memo#delete' do
    context 'ユーザーがログインしていないとき' do
      before do
        memo = create :memo
        delete :delete, :trace_id => memo.trace_id
      end

      it '401 Status Error が返ってくる' do
        expect(response.status).to eq(401)
      end
    end

    context '違うユーザーがdeleteしようとしたとき' do
      before do
        memo = create :memo
        user = create :user
        sign_in user
        patch :update, :trace_id => memo.trace_id, :memo => attributes_for(:memo)
      end

      it '401 Status Errorが返ってくる' do
        expect(response.status).to eq(401)
      end
    end

    context 'メモの作成者と同じユーザーがdeleteしようとしたとき' do
      
    end
  end
end
