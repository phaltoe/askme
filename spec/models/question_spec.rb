require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {
    Question.create(
      :title => "A Brand new Question",
      :content => "What is it about?"
    )
  }

  let(:author) {
    User.create(
      :name => "Mindy",
      :password => "password",
      :email => "email@rspec.com"
    )
  } 

  let(:answerer) {
    User.create(
      :name => "The Answerer",
      :password => "password",
      :email => "answerer@rspec.com"
    )
  }   

  it 'has many answers' do
    question.answers.create
    question.answers.create
    question.answers.create

    expect(question.answers.count).to eq(3)
  end

  it 'belongs to an author' do
    question.author = author

    expect(question.author).to eq(author)
  end

  # it 'has many answerers' do
  # end
end
