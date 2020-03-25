class CreateAssemOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :assem_options do |t|
      t.string :ans_body
      t.boolean :right
      t.float :weight
      t.belongs_to :assem_question, null: false, foreign_key: true
      t.integer :student_id

      t.timestamps
    end
  end
end
