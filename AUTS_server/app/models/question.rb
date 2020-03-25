class Question < ApplicationRecord
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
  belongs_to :thema
  belongs_to :teacher
end
