class Admin::QuestionsController < Admin::BaseController
  before_action :set_question, only: %i[edit update destroy]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_path, success: '質問を作成しました'
    else
      flash.new[:danger] = '質問作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def show; end

  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, success: '質問を更新しました'
    else
      flash.new[:danger] = '質問作成に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy!
    redirect_to admin_questions_path, success: '質問を削除しました'
  end

private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :score_type).tap do |whitelisted|
      whitelisted[:score_type] = whitelisted[:score_type].to_i
    end
  end
end
