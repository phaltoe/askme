class Question < ActiveRecord::Base
  belongs_to :author, 
              class_name: 'User'

  has_many :answers

  has_many :answerers, 
            through: :answers, 
            source: :answerer
  
  has_many :question_categories
  
  has_many :categories, 
            through: :question_categories


  # accepts_nested_attributes_for :categories   
  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes['name'].blank? }       
  # def categories_attributes=(categories)
  #   categories.each do |index, categories_hash|
  #     self.categories.build(:name => categories_hash[:name]) if categories_hash[:name].present?
  #   end
  # end          
end
