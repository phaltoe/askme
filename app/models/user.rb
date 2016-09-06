class User < ActiveRecord::Base
  # has_many :questions
  has_many :authored_questions, 
            class_name: 'Question', 
            foreign_key: :author_id

  has_many :answers

  has_many :answered_questions, 
            through: :answers, 
            source: :question
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    
end
