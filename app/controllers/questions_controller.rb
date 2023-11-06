class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @questions = Question.all
  end

  def calculate
    answers = calculate_params.values
    total_score = answers.map(&:to_i).sum
    session[:total_score] = total_score
    redirect_to result_questions_path
  end

  def result
    @total_score = session[:total_score]
    if @total_score
      @result = Result.find_by("score_range_start <= ? AND score_range_end >= ?", @total_score, @total_score)
      session.delete(:total_score)
    else
      redirect_to root_path, danger: t('.fail')
      return
    end
  end

  private

  def calculate_params
    params.require(:calculate).permit(:answer_1, :answer_2, :answer_3, :answer_4, :answer_5, :answer_6, :answer_7, :answer_8, :answer_9, :answer_10)
  end
end
