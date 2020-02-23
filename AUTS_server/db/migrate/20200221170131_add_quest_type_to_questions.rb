class AddQuestTypeToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :quest_type, :string
  end
end
