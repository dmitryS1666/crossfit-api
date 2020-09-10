# frozen_string_literal: true

class Api::V1::TicketResource < JSONAPI::Resource
  attributes :id, :duration, :visits, :price
end
