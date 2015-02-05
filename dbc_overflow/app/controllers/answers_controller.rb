class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
    render partial: 'create'
    # redirect_to question_path(@question)
  end

  def upvote
     @answer = Answer.find(params[:id])
    @vote_relationship = current_user.avotes.where(answer_id: @answer.id)
    if @vote_relationship.exists?
      @vote_relationship[0].value = 1
      @vote_relationship[0].save
      @answer.points = @answer.avotes.sum(:value)
      @answer.save
      render json: @answer.points
    else
      @user_vote = current_user.avotes.create(answer_id: @answer.id)
      @user_vote.value = 1
      @user_vote.save
      @answer.points = @answer.avotes.sum(:value)
      @answer.save
      render json: @answer.points
    end
  end

  def downvote
    @answer = Answer.find(params[:id])
    @vote_relationship = current_user.avotes.where(answer_id: @answer.id)
    if @vote_relationship.exists?
      @vote_relationship[0].value = -1
      @vote_relationship[0].save
      @answer.points = @answer.avotes.sum(:value)
      p @answer.points
      @answer.save
      render json: @answer.points
    else
      @user_vote = current_user.avotes.create(answer_id: @answer.id)
      @user_vote.value = -1
      @user_vote.save
      @answer.points = @answer.avotes.sum(:value)
      p @answer.points
      @answer.save
      render json: @answer.points
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
   if @answer.user == current_user
    @answer.destroy
    redirect_to question_path(@question)
   else
    redirect_to question_path(@question)
   end
 end

    private
    def answer_params
      params.require(:answer).permit(:name, :answer)
  end
end
