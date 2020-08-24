# frozen_string_literal: true

class Api::V1::ProfileResource < JSONAPI::Resource
  abstract

  def self.find_by_key(key, options = {})
    context = options[:context]
    model = context[:user]
    raise JSONAPI::Exceptions::RecordNotFound, key if model.nil?

    resource_for_model(model).new(model, context)
  end

  singleton singleton_key: -> (context) {
    key = context[:user].try(:id)
    raise JSONAPI::Exceptions::RecordNotFound.new(nil) if key.nil?
    key
  }

  has_one :user, :foreign_key_on => :related, class_name: "User"  
    
end
