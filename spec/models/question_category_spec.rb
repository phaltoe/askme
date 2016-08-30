require 'rails_helper'

RSpec.describe QuestionCategory, :type => :model do
  before do 
    @question = Question.first
    @category = Category.create(name: "Science")
    @question_category = @question.question_categories.create(category: @category)
  end

  it 'belongs to a question' do 
    expect(@question_category.question).to eq(@question)
  end

  it 'belongs to an category' do 
    expect(@question_category.category).to eq (@category)
  end
end
