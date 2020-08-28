# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string           default(""), not null
#  description :string           default(""), not null
#  videoUrl    :string
#  equipment   :string
#

class Exercise < ApplicationRecord
  has_many :users
end