class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.order(params[:sort])
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

   def favorite
    @question = Question.find(params[:id])
    type = params[:type]

    if type == "favorite" && !current_user.favorites.include?(@question)
      current_user.favorites << @question
      redirect_to :back, notice: "You favorited #{@question.title}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@question)
      redirect_to :back, notice: "Unfavorited #{@question.title}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'You already favorited this question!'
    end
  end


  private

  def question_params
    params.require(:question).permit(:title, :content, :author_id, :category_ids => [], :categories_attributes => [:name])
  end

end
