# == Schema Information
#
# Table name: trainings
#
#  id           :bigint           not null, primary key
#  name         :string
#  description  :string
#  trainer_id   :string
#  start_time   :string
#  sections     :array

class Training < ApplicationRecord
  # has_many :sections
  # has_many :sections
  # accepts_nested_attributes_for :sections
end