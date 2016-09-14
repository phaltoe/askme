class AnswersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    if params[:question_id]
      begin
        @answers = Question.find(params[:question_id]).answers
      rescue ActiveRecord::RecordNotFound
        redirect_to question_path, alert: "Question not found"
      end
    else
      @answers = Answer.all
    end
  end

  def show
    if @answer.nil?
      flash[:alert] = "Answer not Found"
      redirect_to question_answers_path(@question)
    end
  end

  def new
    if params[:question_id]
      @question = Question.find_by_id(params[:question_id])
      @answer = @question.answers.build
    end
  end

  def edit
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)

    if @answer.save
      redirect_to @question  
    else
      flash[:message]
      render :new
    end
  end

  def update    
    if @answer.update_attributes(answer_params)
      redirect_to([@answer.question, @answer])
      flash[:message]
    else
      flash[:message]
      render :edit
    end
  end

  def destroy
    @answer.destroy
  end

  private

  def set_answer
    @question = Question.find_by_id(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :content, :user_id)
  end
end
