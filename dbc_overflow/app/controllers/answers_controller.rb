class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to question_path(@question)
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


# # up
# @qvote = current_user.qvotes.where(question_id: @quesiton.id).first
# if @qvote.exists?
#   if @qvote.value == 1
#     @error_message = "you have already up-voted, but you may downvote if you want to change your mind."
#   elsif @qvote.value == 0
#     @qvote.value = 1
#     @question.upvote
#     @qvote.save
#     @question.save
#   elsif @qvote.value == -1
#     @qvote.value = 1
#     @question.upvote
#     @question.upvote
#     @qvote.save
#     @question.save
#   end
# else current_user.qvotes.create(question_id: @quesiton.id)
#   @qvote.value = 1
#   @question.upvote
#   @qvote.save
#   @question.save
# end


# # down
# @qvote = current_user.qvotes.where(question_id: @quesiton.id).first
# if @qvote.exists?
#   if @qvote.value == -1
#     @error_message = "you have already down-voted, but you may upvote if you want to change your mind."
#   elsif @qvote.value = 0
#     @qvote.value = -1
#     @question.downvote
#     @qvote.save
#     @question.save
#     render json: @question.points
#   elsif @qvote.value = 1
#     @qvote.value = -1
#     @question.downvote
#     @question.downvote
#     @qvote.save
#     @question.save
#     render json: @question.points
#   end
# else current_user.qvotes.create(question_id: @quesiton.id)
#   @qvote.value = -1
#   @question.upvote
#   @qvote.save
#   @question.save
#   render json: @question.points
# end

# # question.qvotes.sum(:value)
