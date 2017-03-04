class Schedule < ApplicationRecord
  has_many :messages
  belongs_to :account




  def create_templates(name)
    #create the message templates for primary, secondary & emergency text messages here and save it to the Schedule table.
  end

end
