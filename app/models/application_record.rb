class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.policy_class
    ApplicationPolicy
  end
end
