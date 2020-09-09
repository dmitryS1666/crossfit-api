# == Schema Information
#
# Table name: actions
#
#  id                   :bigint           not null, primary key
#  minute               :integer
#  exercise_id          :string
#  default_value_man    :integer
#  default_value_woman  :integer
#  profile_index        :string
#  ratio                :integer
#  reps                 :integer
#  distance             :integer

class Action < ApplicationRecord
  attr_accessor :minute, :exercise_id, :default_value_man, :default_value_woman, :profile_index, :ration,
              :reps, :distance
end