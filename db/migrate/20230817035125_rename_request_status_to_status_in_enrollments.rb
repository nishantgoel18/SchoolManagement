class RenameRequestStatusToStatusInEnrollments < ActiveRecord::Migration[7.0]
  def change
    rename_column :enrollments, :request_status, :status
  end
end
