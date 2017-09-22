class Project < ApplicationRecord
  include DisplayNameConcern

  validates :year, presence: true
  validates :name, presence: true, uniqueness: { scope: :year }

  validates :start_time, presence: true
  validates :end_time, presence: true

  just_define_datetime_picker :start_time
  just_define_datetime_picker :end_time

  validates_datetime :end_time, after: :start_time

  validates :max_upload_size, presence: true,
            numericality: { greater_than: 0 }

  has_many :assignments, dependent: :delete_all
  has_many :groups, through: :assignments

  has_many :submissions, dependent: :destroy

  scope :current, -> { where('start_time >= ? AND end_time >= ?', Date.today, DateTime.now) }
  scope :ended, -> { where('end_time >= ? AND end_time <= ?', DateTime.now - 1.week, DateTime.now) }

  scope :of_user, -> (user) { joins(:assignments).where('group_id IN (?)', user.group_memberships.select(:group_id)).order('end_time') }

  def user_submission(user)
    submissions.find_by_user_id(user.id)
  end

  def assignment_group(user)
    Group.where('id IN (?)', user.group_memberships.select(:group_id))
         .where('id IN (?)', assignments.select(:group_id)).first
  end

  def user_submissions
    UserSubmissions.project(self).includes(:submission)
  end

  def set_defaults
    self.start_time = Date.today.to_datetime
    self.end_time = start_time + 1.week
    self.year = SchoolDateHelper.school_year(self.start_time)
    self.max_upload_size = 1 * 1024 * 1024 # 1MB
  end
end
