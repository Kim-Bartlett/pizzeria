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
        pizza[:quantity].to_i.times do
          new_pizza = Pizza.create!(order: @order, specialty_type_id: pizza[:specialty_type_id])
          pizza[:topping_ids].each do |id|
            # bug here
            PizzaTopping.create!(pizza: new_pizza, topping_id: id)
          end
        end
      end
    end

    if @order.persisted?
      render status: :created, json: @order.to_json
    else  
      render status: :unprocessable_entity
    end
  end

  def index; end

  def show; end

  def update_status; end

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
                topping_ids: [ :id ]
              ]
    )
  end
end
