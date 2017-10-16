class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true,
            uniqueness: { scope: :user,
                          message: I18n.t('submission.unique.error') }

  mount_uploader :file, SubmissionUploader

  validates_presence_of :file, message: I18n.t('submission.file_required'), if: -> { new_record? or file_changed? }
  validate :file_size

  if Rails.configuration.x.apitp.team_submissions
    belongs_to :team
    validates :team, presence: true
  else
    belongs_to :team, optional: true
  end

  validates :project, presence: true,
            uniqueness: { scope: :team,
                          message: I18n.t('submission.unique.error')},
            unless: -> (record) { record.team_id.nil? }

  def file_size
    unless file.file.nil?
      if file.file.size > project.max_upload_size
        errors.add(:file, I18n.t('submission.size.error',
                            size: ApplicationController.helpers.number_to_human_size(file.file.size - project.max_upload_size)))
      end
    end
  end
end
