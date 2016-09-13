class FavoriteQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_uniqueness_of :user_id, 
                           scope: :question_id
end
