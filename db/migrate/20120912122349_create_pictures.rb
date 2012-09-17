class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :history_id
      t.string :picture

      t.timestamps
    end
  end
end