class SubmissionsController < ApplicationController
  include DateHelper
  before_action :authenticate_user!, only: [ :create ]

  def create
    submission = Submission.new(file: params[:submission][:file])
    submission.project = UserProject.of_user(current_user).find(params[:submission][:project_id])
    submission.user = current_user
    submission.team = submission.project.team

    # Ensure access
    authorize submission

    if submission.save
      # Send e-mail about submitted file
      ProjectMailer.submitted(submission).deliver_later

      redirect_to project_path(submission.project),
                  notice: I18n.t('submissions.create.success',
                                 date: render_date(submission.created_at,
                                                   submission.project.end_time,
                                                   I18n.t('project.due_date_distance')))
    else
      # Delete file after failure
      submission.file.file.delete unless submission.file.file.nil?

      redirect_to project_path(submission.project),
                  alert: I18n.t('submissions.create.error', error: submission.errors.first[1])
    end
  end

  def show
    submission_user = if admin_user_signed_in?
                        current_admin_user
                      else
                        current_user
                      end

    if submission_user.nil?
      # Delegate to Devise when no user
      authenticate_user!
    end

    # Find the submission
    submission = Submission.find(params[:id])

    # Authorize
    Pundit.authorize(submission_user, submission, :show?)

    # Render the file
    extension = File.extname(submission.file.path)
    file_name = "#{submission.project_id}_#{submission.project.display_name}_#{submission.user_id}_#{submission.user.name}_#{submission.id}"
    send_file submission.file.path, filename: (file_name.parameterize + extension)
  end
end
