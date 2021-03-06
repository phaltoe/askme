class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: [:index, :favorite]

  helper_method :sort_column, :sort_direction

  def index
    @questions = Question.order(sort_column + " " + sort_direction)
    authorize @questions
  end

  def show
    if @question.nil?
      redirect_to questions_path
    end
  end

  def new
    @question = current_user.authored_questions.build
    authorize @question
  end

  def edit
  end

  def create
    @question = current_user.authored_questions.build(question_params)
    authorize @question
    if @question.save
      flash[:success] = "Question Successfully Created"
      redirect_to @question
    else
      flash[:error] = "Something Went Wrong"
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:sucess] = "Question Successfully Created"
      redirect_to @question
    else
      flash[:error] = "Something Went Wrong"
      render :edit
    end
  end

  def destroy
    @question.destroy
    
    flash[:sucess] = "Question Successfully Deleted"
    redirect_to questions_path
  end

   def favorite
    @question = Question.friendly.find(params[:id])
    type = params[:type]

    if type == "favorite" && !current_user.favorites.include?(@question)
      current_user.favorites << @question
      redirect_to :back

    elsif type == "unfavorite"
      current_user.favorites.delete(@question)
      redirect_to :back

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'You already favorited this question!'
    end
  end


  private

  def set_question
    @question = Question.friendly.find(params[:id])
    authorize @question
  end

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
