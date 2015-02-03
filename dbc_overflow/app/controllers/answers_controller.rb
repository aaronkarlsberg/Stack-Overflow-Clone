class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    redirect_to question_path(@question)
  end

  def upvote
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @points = @answer.points += 1
    @answer.save
    render json: @points
  end

  def downvote
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @points = @answer.points -= 1
    @answer.save
    render json: @points
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end

    private
    def answer_params
      params.require(:answer).permit(:name, :answer)
  end
end
