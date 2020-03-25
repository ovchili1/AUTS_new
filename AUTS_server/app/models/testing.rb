class Testing < ApplicationRecord
  belongs_to :test
  belongs_to :student
  has_many :assem_questions, dependent:  :destroy
  accepts_nested_attributes_for :assem_questions
end
