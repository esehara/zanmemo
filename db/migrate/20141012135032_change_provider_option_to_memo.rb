class ChangeProviderOptionToMemo < ActiveRecord::Migration
  def change
    change_column :memos, :content, :text, null: false
  end
end
