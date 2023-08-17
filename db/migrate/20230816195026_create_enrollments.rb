class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :batch_id
      t.string :request_status, default: 'Pending'

      t.timestamps
    end
    add_index :enrollments, :user_id
    add_index :enrollments, :batch_id
  end
end
