class DiariesController < ApplicationController
  def new
    @date = Date.current
    @diary_form = DiaryForm.new
  end

  def create
    @diary_form = DiaryForm.new(diary_form_params)

    if @diary_form.save
      redirect_to root_path, success: t('.success')
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