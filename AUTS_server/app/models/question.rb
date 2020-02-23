class Question < ApplicationRecord
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  belongs_to :thema
  belongs_to :teacher
end
