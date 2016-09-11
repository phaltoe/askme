class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = current_user.authored_questions.build
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.authored_questions.build(question_params)
    @question.save

    redirect_to @question
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)

    redirect_to @question
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to root_path
  end


  private

  def question_params
    params.require(:question).permit(:title, :content, :author_id, :category_ids => [], :categories_attributes => [:name])
  end

end
