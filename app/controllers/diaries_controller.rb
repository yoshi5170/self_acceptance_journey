class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update]

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
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @entries = @diary.diary_entries
  end

  def edit
    @diary_entries = @diary.diary_entries.order(:id)
    @diary_form = DiaryForm.new(user_id: @diary.user_id, entries_contents: @diary_entries.map(&:content), entries_ids: @diary_entries.map(&:id))
  end

  def update
    @diary_form = DiaryForm.new(diary_form_params)
    if @diary_form.update
      redirect_to diary_path(@diary.id), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_form_params
    params.require(:diary_form).permit(:user_id, entries_contents: [], entries_ids: [])
  end
end