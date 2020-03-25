class AddNumQuestToTestings < ActiveRecord::Migration[6.0]
  def change
    add_column :testings, :num_of_quest, :integer
  end
end
