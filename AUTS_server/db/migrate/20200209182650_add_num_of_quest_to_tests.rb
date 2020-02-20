class AddNumOfQuestToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :num_of_quest, :integer
  end
end
