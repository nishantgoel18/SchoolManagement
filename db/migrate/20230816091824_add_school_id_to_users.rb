class AddSchoolIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :school_id, :integer
    add_index :users, :school_id
  end
end
