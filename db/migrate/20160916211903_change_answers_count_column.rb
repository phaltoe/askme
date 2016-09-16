class ChangeAnswersCountColumn < ActiveRecord::Migration
  def change
    change_column :questions, :answers_count,  :integer, default: 0
  end
end
