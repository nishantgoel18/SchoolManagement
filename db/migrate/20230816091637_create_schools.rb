class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.text :about

      t.timestamps
    end
  end
end
