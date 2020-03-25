class CreateTestings < ActiveRecord::Migration[6.0]
  def change
    create_table :testings do |t|
      t.integer :num_of_right_options
      t.integer :student_id
      t.belongs_to :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
