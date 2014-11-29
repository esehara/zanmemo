require 'rails_helper'
require 'memo'
RSpec.describe Memo, :type => :model do
  describe "#save" do
    context 'セーブできないパターン' do
      it '空白のメモを保存しようとするとエラーになる' do
        memo = build :memo, :content => ""
        expect(memo.save).to be false
      end

      it '改行だけでもエラーになる' do
        memo = build :memo, :content => "\n\n"
        expect(memo.save).to be false
      end

      it 'スペースだけでもエラーになる' do
        memo = build :memo, :content => "   "
        expect(memo.save).to be false
      end
    end
  end
end
