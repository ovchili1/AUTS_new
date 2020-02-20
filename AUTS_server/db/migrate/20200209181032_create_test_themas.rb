class CreateTestThemas < ActiveRecord::Migration[6.0]
  def change
    create_table :test_themas do |t|
      t.belongs_to :thema, null: false, foreign_key: true
      t.belongs_to :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
