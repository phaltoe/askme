class Category < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, 
               use: :slugged 
  
  has_many :question_categories
  has_many :questions, 
            through: :question_categories

  validates_presence_of :name

end
