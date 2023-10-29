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
    session.delete(:total_score)
  end

  private

  def calculate_params
    params.require(:calculate).permit(:answer_1, :answer_2, :answer_3, :answer_4, :answer_5, :answer_6, :answer_7, :answer_8, :answer_9, :answer_10)
  end
end
