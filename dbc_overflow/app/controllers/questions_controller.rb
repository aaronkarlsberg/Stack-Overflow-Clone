class QuestionsController < ApplicationController
  respond_to :js

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.buil(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def upvote
    p "Rilke sucks"
    @question = Question.find(params[:id])
    @question.upvote

    respond_with(@question)
  end

  def downvote
    @question = Question.find(params[:id])
    @points = @question.points -= 1
    @question.save
    render json: @points
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:title, :content)
    end
end
