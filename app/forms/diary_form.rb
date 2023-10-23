class DiaryForm
  include ActiveModel::Model

  attr_accessor :user_id, :entries_contents, :entries_ids

  def initialize(attributes = {})
    super(attributes)
    @entries_contents ||= []
  end

  validates_presence_of :user_id
  validate :all_entries_must_be_present

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      diary = Diary.create(user_id: user_id, date: Time.current)
      entries_contents.each do |content|
        diary.diary_entries.create!(content: content)
      end
    end

    true
  rescue ActiveRecord::RecordInvalid
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

  def all_entries_must_be_present
    if entries_contents.any?(&:blank?)
      errors.add(:base, "すべてのフォームに入力してください")
    end
  end
end