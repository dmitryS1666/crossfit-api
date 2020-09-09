# == Schema Information
#
# Table name: sections
#
#  id            :bigint          not null, primary key
#  duration      :integer
#  start_minute  :integer
#  section_type  :string
#  actions       :array

class Section < ApplicationRecord
  # has_many :actions
end