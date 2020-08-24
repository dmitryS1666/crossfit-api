# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  phone_number :string
#  company_name :string
#  status       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string
#  desc         :text
#  itin         :string
#  code         :string
#  manager_id   :bigint
#

class Account < ApplicationRecord
  has_many :users
end
