class Group < ApplicationRecord
  include DisplayNameConcern
  include UnicityConcern

  validates :year, presence: true
  validates :name, presence: true, uniqueness: { scope: :year }
  validates :admin, presence: true

  belongs_to :admin, foreign_key: :admin_user_id, class_name: 'AdminUser'

  has_many :assignments, dependent: :delete_all
  has_many :projects, through: :assignments

  has_many :group_memberships, dependent: :delete_all
  has_many :users, through: :group_memberships

  scope :current, -> { where(year: SchoolDateHelper.school_year) }

  scope :administered, -> (admin) { where(admin_user_id: admin.id) }

  validate :group_assignment_uniqueness
end
