class Account < ApplicationRecord
  authenticates_with_sorcery!
  has_many :messages, through: :schedules
  has_many :schedules
end
