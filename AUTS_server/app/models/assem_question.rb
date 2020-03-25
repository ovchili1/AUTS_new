class AssemQuestion < ApplicationRecord
  belongs_to :testing
  has_many :assem_options, :dependent =>  :destroy
  has_many :assem_answers, :dependent => :destroy

  accepts_nested_attributes_for :assem_answers
  accepts_nested_attributes_for :assem_options
end
