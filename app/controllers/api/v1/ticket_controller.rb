class Api::V1::TicketController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :authorize_ticket_policy, only: %i[index create update destroy_all destroy all_ticket]
  before_action :load_ticket, only: %i[show edit update]

  def index
    ticket = Ticket.all.where(user_id: params[:user_id])
    render json: {message: ticket}
  end

  def destroy_all
    Ticket.delete_all
    render plain: nil, status: 200, content_type: 'application/json'
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render plain: @ticket.to_json,
             status: 200,
             content_type: 'application/json'
    else
      render plain: @ticket.errors,
             status: :unprocessable_entity,
             content_type: 'application/json'
    end
  end

  def update
    if @ticket.update(ticket_params)
      @ticket.save
      render plain: {
          id: @ticket.id,
          duration: @ticket.duration,
          visits: @ticket.visits,
          price: @ticket.price
      }.to_json,
             status: 200,
             content_type: 'application/json'
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def all_ticket
    render json: serialize_ticket(Ticket.all)
  end

  private

  def authorize_ticket_policy
    authorize Ticket, policy_class: TicketPolicy
  end

  def ticket_params
    params.permit(
        :duration,
        :visits,
        :price
    )
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def serialize_ticket(ticket)
    ticket_resources = ticket.map { |t| Api::V1::TicketResource.new(t, nil) }
    JSONAPI::ResourceSerializer.new(Api::V1::TicketResource).serialize_to_hash(
        ticket_resources
    )
  end

end
