module CustomTokenResponse
  def body
    additional_data = {}
    user = User.find_by_id(@token.resource_owner_id)
    if user
      additional_data = {
          :user_id => user.id,
          :trainer => user.trainer,
          :client => user.client
      }
    end

    # call original `#body` method and merge its result with the additional data hash
    super.merge(additional_data)
  end
end