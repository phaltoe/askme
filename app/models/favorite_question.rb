class FavoriteQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_uniqueness_of :question_id
end
