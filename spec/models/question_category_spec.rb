require 'rails_helper'

RSpec.describe QuestionCategory, :type => :model do
  # before do 
  #   @question = Question.first
  #   @category = Category.first
  #   @question.categories << @category
  #   @question.save
  #   # @question_category = @question.categories.create(category: @category)
  #   @question_category = QuestionCategory.last
  # end

  let(:question) {
    Question.create(
      :title => "A Brand new Question",
      :content => "What is it about?"
    )
  }

  # let(:category) {
  #   Category.create(
  #     :name => "Tag"
  #     )
  # }

  # let(:question_category) {
  #   QuestionCategory.first
  # }

  # it 'belongs to a question' do 
    
  #   expect(question_category.question).to eq(question)
  # end

  # it 'belongs to an category' do 
  #   expect(question_category.category).to eq (category)
  # end
end
