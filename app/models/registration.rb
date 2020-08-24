# == Schema Information
#
# Table name: registrations
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  email        :string
#  complete     :boolean
#  token        :string
#  name         :string
#  company      :string
#  phone        :string
#  password     :string
#  unp          :string
#  first_name   :string
#  last_name    :string
#  organization :string
#

class Registration < ApplicationRecord
  before_save :set_access_token

  def set_access_token
    self.token = generate_token
  end

  def generate_token
    token = SecureRandom.hex(10)
  end
end
