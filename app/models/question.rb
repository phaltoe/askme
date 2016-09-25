class Question < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, 
               use: :slugged 
  
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

  # accepts_nested_attributes_for :categories, 
  #                                reject_if: :reject_categories                


   validates_presence_of :title 


   def categories_attributes=(new_categories)
      new_categories.each do |index, categories_hash|
        new_category = Category.find_or_create_by(:name => categories_hash[:name]) if 
        categories_hash[:name].present? 
        
        self.categories << new_category if new_category.present?
      end
   end



  # def reject_categories(attributes)
  #   attributes['name'].blank?
  # end

  def self.most_answered
    self.order("answers_count DESC").limit(3)
  end

  def first_answers
    answers.limit(3)
  end

  def have_more_answers
    answers.count > 3
  end
end
