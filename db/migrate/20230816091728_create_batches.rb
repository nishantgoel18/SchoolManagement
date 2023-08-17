class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.integer :school_id
      t.string :name

      t.timestamps
    end
    add_index :batches, :school_id
  end
end
