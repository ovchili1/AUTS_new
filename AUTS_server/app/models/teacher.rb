class Teacher < User
  has_many :themas, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :questions, dependent: :destroy
end