class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :trace_id
      t.timestamps
    end
    add_index :users, [:provider, :uid], unique: true
    add_index :users, :trace_id, unique: true
  end
end
