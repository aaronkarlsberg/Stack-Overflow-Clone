class QuestionsController < ApplicationController
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
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvote

    render json: @question.points
  end

  def downvote
    @question = Question.find(params[:id])
    @question.downvote
    render json: @question.points
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
