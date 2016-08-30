class Question < ActiveRecord::Base
  has_many :question_categories
  has_many :categories, through: :question_categories
  belongs_to :user
  has_many :answers
end
