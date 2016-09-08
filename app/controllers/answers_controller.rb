class AnswersController < ApplicationController

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
    if params[:question_id]
      question = Question.find_by_id(params[:question_id])
      @answer = question.answers.find_by_id(params[:id])
      if @answer.nil?
        flash[:alert] = "answer not found"
        redirect_to question_answers_path(@question)
      end
    else
      @answer = Answer.find(params[:id])
    end
  end

  def new
    if params[:question_id]
      question = Question.find_by_id(params[:question_id])
      @answer = question.answers.build
    end
  end

  def edit
    question = Question.find_by_id(params[:question_id])
    @answer = question.answers.find(params[:id])
  end

  def create
    question = Question.find(params[:question_id])
    @answer = question.answers.create(answer_params)

    redirect_to([@answer.question, @answer])
  end

  def update
    question = Question.find_by_id(params[:question_id])
    @answer = question.answers.find(params[:id])
    
    if @answer.update_attrivutes(answer_params)
      redirect_to([@answer.question, @answer])
    else
      render :edit
    end
  end

  def destroy
    question = Question.find_by_id(params[:question_id])
    @answer = question.answers.find(params[:id])

    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end  
end
