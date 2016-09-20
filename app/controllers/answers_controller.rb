class AnswersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  before_action :set_question, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_answer, only: [:edit, :update, :destroy]

  after_action :verify_authorized, except: [:index, :new]

  def index
    if params[:question_id]
      begin
        @answers = Question.friendly.find(params[:question_id]).answers
        authorize @answers
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Question not Found"
        redirect_to questions_path
      end
    else
      @answers = Answer.all
      authorize @answers
    end
  end

  def show
    if params[:question_id]
      @question = Question.friendly.find(params[:question_id])
      authorize @question
      @answer = @question.answers.find_by_id(params[:id])
      if @answer.nil?
        flash[:alert] = "Answer not Found"
        redirect_to question_answers_path(@question)
      end
    else
      @answer = Answer.find(params[:id])
    end
  end

  def new
    @answer = @question.answers.build
  end

  def edit
  end

  def create
    @answer = @question.answers.create(answer_params)
    authorize @answer

    if @answer.save
      flash[:success] = "Answer Successfully Created"
      redirect_to @question  
    else
      flash[:message]
      render :new
    end
  end

  def update    
    if @answer.update_attributes(answer_params)
      flash[:success] = "Answer Updated Successfully"
      redirect_to([@answer.question, @answer])
    else
      flash[:error] = "Something Went Wrong"
      render :edit
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer Successfully Deleted"
    redirect_to question_answers_path
  end

  private

  def set_question
    @question = Question.friendly.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])

    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(:title, :content, :user_id)
  end
end
