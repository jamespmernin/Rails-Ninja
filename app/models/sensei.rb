class Sensei < ApplicationRecord
  belongs_to :dojo
  has_many :students, dependent: :destroy
end
