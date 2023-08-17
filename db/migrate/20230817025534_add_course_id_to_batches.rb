class AddCourseIdToBatches < ActiveRecord::Migration[7.0]
  def change
    add_column :batches, :course_id, :integer
    add_index :batches, :course_id
  end
end
