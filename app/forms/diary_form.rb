class DiaryForm
  include ActiveModel::Model

  attr_accessor :user_id, :entries_contents, :entries_ids

  def initialize(attributes = nil, diary: Diary.new)
    @diary = diary
    attributes ||= default_attributes
    super(attributes)
  end

  validate :all_entries_must_be_present

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      # (user_id: user_id, date: Time.current.to_date)
      diary = Diary.create!(user_id:, date: Time.current.to_date)
      entries_contents.each do |content|
        diary.diary_entries.create!(content:)
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
    false
  end

  def update
    return false unless valid?

    ActiveRecord::Base.transaction do
      entries_ids.each_with_index do |id, index|
        entry = DiaryEntry.find(id)
        entry.update!(content: entries_contents[index])
      end
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  attr_reader :diary

  def default_attributes
    {
      user_id: diary.user_id,
      entries_contents: diary.diary_entries.map(&:content),
      entries_ids: diary.diary_entries.map(&:id)
    }
  end

  def all_entries_must_be_present
    errors.add(:base, 'すべてのフォームに入力してください') if entries_contents.any?(&:blank?)
  end
end
