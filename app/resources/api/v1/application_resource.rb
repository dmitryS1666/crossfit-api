class Api::V1::ApplicationResource < JSONAPI::Resource
  abstract

  private

  class Selfless < JSONAPI::Resource
    def custom_links(options)
      { self: nil }
    end
  end

  def self.current_user(options)
    options.fetch(:context).fetch(:current_user)
  end
end
