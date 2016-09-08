class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    # raise params.inspect
    @question = Question.new(question_params)
    @question.save

    redirect_to home_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :category_ids => [], :categories_attributes => [:name])
  end

end
