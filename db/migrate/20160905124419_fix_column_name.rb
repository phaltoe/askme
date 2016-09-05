class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :questions, :user_id, :author_id
  end
end
