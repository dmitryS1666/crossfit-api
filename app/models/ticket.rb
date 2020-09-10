# == Schema Information
#
# Table name: ticket
#
#  id        :string           not null, primary key
#  duration  :integer
#  visits    :integer
#  price     :integer
#

class Ticket < ApplicationRecord
  # has_many :sections
  # has_many :sections
  # accepts_nested_attributes_for :sections
end