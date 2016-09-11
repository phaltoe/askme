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

  has_many :favorite_questions

  has_many :favorited_by, 
            through: :favorite_questions, 
            source: :user        


  def categories_attributes=(new_categories)
    new_categories.each do |index, categories_hash|
      new_category = Category.find_or_create_by(:name => categories_hash[:name]) if 
      !categories_hash[:name].nil? 
      
      self.categories << new_category unless new_category.nil? 
    end
  end 
end
