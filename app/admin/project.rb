ActiveAdmin.register Project do
  permit_params :year, :name, :url, :max_upload_size,
                :start_time_date, :start_time_time_hour, :start_time_time_minute,
                :end_time_date, :end_time_time_hour, :end_time_time_minute,
                :group_ids => []

  index do
    selectable_column
    id_column
    column :year
    column :name
    column :start_time
    column :end_time
    actions
  end

  filter :year
  filter :name
  filter :start_time
  filter :end_time

  form do |f|
    f.object.set_defaults if f.object.new_record?

    f.inputs do
      f.input :year
      f.input :name
      f.input :start_time, as: :just_datetime_picker
      f.input :end_time, as: :just_datetime_picker
      f.input :url
      f.input :max_upload_size
      f.input :groups, as: :check_boxes,
              collection: Group.where(year: f.object.year).map { |group| [group.display_name, group.id] }
    end
    f.actions
  end

  controller do

  end

  show do
    attributes_table do
      row :display_name
      row :start_time
      row :end_time
      row :url
      row :max_upload_size
      row :created_at
      row :updated_at
    end

    panel I18n.t('active_admin.project.show.submission_status') do
      table_for project.user_submissions do
        column :name do |user, _submission|
          user.name
        end
        column :email do |user, _submission|
          link_to user.email, "mailto:#{user.email}"
        end
        column I18n.t('activerecord.attributes.submission.created_at') do |_user, submission|
          if submission.nil?
            span t('active_admin.project.show.submission_missing'), class: 'submission-missing'
          else
            time_diff = submission.created_at - project.end_time
            link_to I18n.localize(submission.created_at), submission.file.url,
                    class: time_diff > 0 ? 'submission-late' : 'submission-ok'
          end
        end
        column do |user, submission|
          unless submission.nil?
            link_to I18n.t('active_admin.delete'),
                    admin_submission_path(submission),
                    method: :delete,
                    confirm: "Delete submission from #{user.name} for #{project.name}?"
          end
        end
      end
    end
  end

  sidebar I18n.t('active_admin.project.show.assignments'), only: :show do
    table_for project.groups do
      column t('activerecord.attributes.group.display_name') do |group|
        link_to group.display_name, admin_group_path(group)
      end
    end
  end

end
