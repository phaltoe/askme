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

  accepts_nested_attributes_for :categories, 
                                 reject_if: :reject_categories                


   validates_presence_of :title                       

  def reject_categories(attributes)
    attributes['name'].blank?
  end

  def self.most_answered
    self.order("answers_count DESC").limit(3)
  end

end
