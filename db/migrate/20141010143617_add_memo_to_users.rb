class AddMemoToUsers < ActiveRecord::Migration
  def change
    add_reference :memos, :user, index: true
  end
end
