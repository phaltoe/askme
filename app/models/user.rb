class User < ActiveRecord::Base
  has_many :authored_questions, 
            class_name: 'Question', 
            foreign_key: :author_id

  has_many :answers

  has_many :answered_questions, 
            through: :answers, 
            source: :question

  has_many :favorite_questions
  
  has_many :favorites, 
            through: :favorite_questions, 
            source: :question          
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         # :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :omniauthable, 
         :omniauth_providers => [:facebook]

  validates_presence_of :name

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end      
  end
    
end
