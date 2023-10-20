class DiariesController < ApplicationController
  def index
    @diaries = current_user.diaries.includes(:diary_entries).order(created_at: :desc)
  end

  def new
    @date = Date.current
    @diary_form = DiaryForm.new
  end

  def create
    @diary_form = DiaryForm.new(diary_form_params)

    if @diary_form.save
      redirect_to diaries_path, success: t('.success')
    else
      flash.now[:danger]= t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def diary_form_params
    params.require(:diary_form).permit(:user_id, entries_contents: [])
  end
end