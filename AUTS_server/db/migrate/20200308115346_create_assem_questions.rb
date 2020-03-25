class CreateAssemQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :assem_questions do |t|
      t.text :quest_body
      t.boolean :right
      t.belongs_to :testing, null: false, foreign_key: true

      t.timestamps
    end
  end
end