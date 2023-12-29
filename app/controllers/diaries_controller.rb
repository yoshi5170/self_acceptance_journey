class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:index]

  def index
    @diaries = @q.result(distinct: true).includes(:diary_entries).order(created_at: :desc)
  end

  def new
    @date = Date.current
    @diary_form = DiaryForm.new
  end

  def create
    @date = Date.current
    @diary_form = DiaryForm.new(diary_form_params.merge(user_id: current_user.id))

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
    @diary_form = DiaryForm.new(diary: @diary)
  end

  def update
    @diary_form = DiaryForm.new(diary_form_params, diary: @diary)
    if @diary_form.update
      redirect_to diary_path(@diary.id), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary.destroy!
    redirect_to diaries_path, success: t('.success')
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_form_params
    params.require(:diary_form).permit(entries_contents: [], entries_ids: [])
  end

  def set_q
    @q = current_user.diaries.ransack(params[:q])
  end
end
