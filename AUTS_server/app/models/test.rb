class Test < ApplicationRecord
  has_many :test_themas, dependent: :destroy
  has_many :themas, through: :test_themas


  belongs_to :teacher
end
