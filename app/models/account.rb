class Account < ApplicationRecord
  authenticates_with_sorcery!
  has_many :messages, through: :schedules
  has_many :schedules

  #generates random number for account verification process
  def self.generate
    rand(100000..999999).to_s
  end

  def self.send_confirmation_to(account)
    verification = self.generate
    account.update(verification: verification)
    Message.send_code(account, verification)
  end

end
