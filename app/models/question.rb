class Question < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :answers
  has_many :answerers, through: :answers, :source :answerer
  
  has_many :question_categories
  has_many :categories, through: :question_categories
end
