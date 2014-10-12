class AddMemosToTraceid < ActiveRecord::Migration
  def change
    add_column :memos, :trace_id, :string
    change_column :memos, :trace_id, :string, :null => false
  end
end
