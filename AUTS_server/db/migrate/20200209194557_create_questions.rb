class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :quest_body
      t.belongs_to :thema, null: false, foreign_key: true
      t.integer :teacher_id

      t.timestamps
    end
  end
end
