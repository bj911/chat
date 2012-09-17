class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :send_id
      t.integer :recive_id
      t.string :message

      t.timestamps
    end
  end
end