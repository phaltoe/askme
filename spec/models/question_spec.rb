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

  let(:answerer_2) {
    User.create(
      :name => "The Second Answerer",
      :password => "password",
      :email => "second_answerer@rspec.com"
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

  it 'has many answerers' do
    question.answerers << answerer
    question.answerers << answerer_2
    question.answerers << author

    expect(question.answerers.count).to_not eq(2)
    expect(question.answerers.count).to eq(3)
  end

  it 'has many categories' do
    question.categories.create
    question.categories.create

    expect(question.categories.count).to_not eq(1)
    expect(question.categories.count).to eq(2)
  end
end
