class Answer < ActiveRecord::Base
  belongs_to :answerer, 
              class_name: 'User', 
              foreign_key: :user_id
              
  belongs_to :question
end
