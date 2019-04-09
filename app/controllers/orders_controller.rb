class OrdersController < ApplicationController
  def create
    Order.transaction do
      params = create_params.except(:address, :customer, :pizzas)

      customer_params = create_params[:customer]
      customer = Customer.find_or_initialize_by(email: customer_params[:email])
      customer.update_attributes(customer_params)

      # need to find by downcase here
      address = Address.find_or_create_by(create_params[:address])

      @order = Order.create!(params.merge(address: address, customer: customer))

      create_params[:pizzas].each do |pizza|
        Pizza.create_pizza!(pizza[:quantity], @order.id, pizza[:specialty_type_id], pizza[:topping_ids])
      end
    end

    if @order.persisted?
      render status: :created, json: { order: @order.to_json }
    else
      render status: :unprocessable_entity
    end
  end

  def index
    if index_params[:filter] == 'all'
      @orders = Order.all
    elsif index_params[:filter] == 'closed'
      @orders = Order.where(status: Order.statuses[:complete] | Order.statuses[:cancelled])
    else
      @orders = Order.where.not(status: Order.statuses[:complete] | Order.statuses[:cancelled])
    end

    render status: :ok, json: { orders: @orders.map(&:to_json) }
  end

  def show
    @order = Order.find(show_params[:id])
    if @order.present?
      render status: :ok, json: { order: @order.to_json }
    else
      render status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(update_params[:id])
    if @order.present?
      @order.update!(status: Order.statuses[update_params[:status].to_sym])
      render status: :ok, json: { order: @order.to_json }
    else
      render status: :unprocessable_entity
    end
  end

  def create_params
    params.require(:order).permit(
      :delivery,
      address: [ :city, :state, :street, :zip ],
      customer: [
                  :email,
                  :first_name,
                  :last_name,
                  :phone
                ],
      pizzas: [
                :quantity,
                :specialty_type_id,
                topping_ids: []
              ]
    )
  end

  def index_params
    params.permit(:filter)
  end

  def update_params
    params.require(:order).permit(:id, :status)
  end

  def show_params
    params.require(:order).permit(:id)
  end
end
