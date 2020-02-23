class Thema < ApplicationRecord
  belongs_to :teacher
  has_many :test_themas, dependent: :destroy
  has_many :tests, through: :test_themas
  has_many :questions

end
