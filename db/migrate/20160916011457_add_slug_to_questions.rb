class AddSlugToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :slug, :string
    add_index :questions, :slug, unique: true
  end
end
