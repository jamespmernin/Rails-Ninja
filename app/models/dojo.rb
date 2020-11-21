class Dojo < ApplicationRecord
  has_many :senseis, dependent: :destroy
  has_many :students, through: :senseis
end
