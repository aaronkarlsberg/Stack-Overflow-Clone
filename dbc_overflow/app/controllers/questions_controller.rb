

class QuestionsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all

    @response = HTTParty.get("https://api.github.com/zen", :headers =>{"Authorization" => "token " + ENV["RESPONSE_TOKEN"], "User-Agent" => "xyz"})
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
    if @question.user != current_user
      redirect_to root_path
    end
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      # redirect_to @question
      # render json: @question
      p "*"*100
      p @question
      render partial: 'create'
    else
      render partial: 'form', status: 422
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @vote_relationship = current_user.qvotes.where(question_id: @question.id)
    if @vote_relationship.exists?
      @vote_relationship[0].value = +1
      @vote_relationship[0].save
      @question.points = @question.qvotes.sum(:value)
      p @question.points
      @question.save
      render json: @question.points
    else
      @user_vote = current_user.qvotes.create(question_id: @question.id)
      @user_vote.value = +1
      @user_vote.save
      @question.points = @question.qvotes.sum(:value)
      p @question.points
      @question.save
      render json: @question.points
    end
  end

  def downvote
    @question = Question.find(params[:id])
    @vote_relationship = current_user.qvotes.where(question_id: @question.id)
    if @vote_relationship.exists?
      @vote_relationship[0].value = -1
      @vote_relationship[0].save
      @question.points = @question.qvotes.sum(:value)
      p @question.points
      @question.save
      render json: @question.points
    else
      @user_vote = current_user.qvotes.create(question_id: @question.id)
      @user_vote.value = -1
      @user_vote.save
      @question.points = @question.qvotes.sum(:value)
      p @question.points
      @question.save
      render json: @question.points
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.user == current_user
      if @question.update(question_params)
        redirect_to @question
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.user == current_user
      @question.destroy
      redirect_to root_path
    else
      redirect_to questions_path
   end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content)
    end
end
