class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  helper_method :sort_column, :sort_direction

  def index
    @questions = Question.order(sort_column + " " + sort_direction)
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

  def sort_column
    Question.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def question_params
    params.require(:question).permit(:title, :content, :author_id, :category_ids => [], :categories_attributes => [:name])
  end

end
