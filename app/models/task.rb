class Task < ApplicationRecord
  after_initialize :set_default_value

  belongs_to :subject
  #validates :subject_id, presence: true #Even if the subject which have the id is not existing in DB, the field goes through validation
  validates :subject, presence: true

  validates :description, presence: true
  validates :registration_date, presence: true
  validates :first_reminder_date, presence: true
  validates :second_reminder_date, presence: true
  validates :third_reminder_date, presence: true
  
  validate :first_reminder_date_check
  validate :second_reminder_date_check
  validate :third_reminder_date_check

  def first_reminder_date_check
    errors.add(:first_reminder_date, "is earlier than registration_date") if
    [self.first_reminder_date, self.registration_date].compact.max == self.registration_date
  end 

  def second_reminder_date_check
    errors.add(:second_reminder_date, "is earlier than first_reminder_date") if
    [self.second_reminder_date, self.first_reminder_date].compact.max == self.first_reminder_date
  end 

  def third_reminder_date_check
    errors.add(:third_reminder_date, "is earlier than second_reminder_date") if
    [self.third_reminder_date, self.second_reminder_date].compact.max == self.second_reminder_date
  end 

  

  private
  def set_default_value
    self.registration_date  ||= Time.now.getutc 
    self.first_reminder_date ||= registration_date + 1.days
    self.second_reminder_date ||= registration_date + 1.weeks
    self.third_reminder_date ||= registration_date + 1.months
    self.first_check ||= false
    self.second_check ||= false
    self.third_check ||= false
  end
  
  
end
