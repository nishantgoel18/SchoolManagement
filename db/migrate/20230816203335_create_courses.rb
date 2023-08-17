class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :school_id

      t.timestamps
    end
    add_index :courses, :school_id
  end
end
