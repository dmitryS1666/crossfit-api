# == Schema Information
#
# Table name: user_contacts
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  phone1     :string
#  phone2     :string
#  email      :string
#  desc       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#

class UserContact < ApplicationRecord
    belongs_to :user

end
