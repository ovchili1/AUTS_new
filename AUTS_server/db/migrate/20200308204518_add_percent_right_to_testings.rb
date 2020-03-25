class AddPercentRightToTestings < ActiveRecord::Migration[6.0]
  def change
    add_column :testings, :percent_Right, :integer
  end
end
