class Account < ApplicationRecord
  authenticates_with_sorcery!
  has_many :messages
  has_many :schedules
end
