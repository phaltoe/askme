class ChangeUserColumn < ActiveRecord::Migration
  def change
    change_column :users, :role, 'integer USING CAST(role AS integer)'
  end
end
