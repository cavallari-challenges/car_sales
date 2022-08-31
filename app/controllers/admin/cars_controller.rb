# frozen_string_literal: true

module Admin
  class CarsController < Admin::ApplicationController
    before_action :set_variables, only: %i[new edit]
    before_action :set_car, only: %i[edit update destroy]

    def index
      @cars = Car.joins(:dealership).includes(:dealership)
    end

    def new
      @car = Car.new
    end

    def create
      @car = Car.new(permitted_params)

      if @car.save
        redirect_to admin_cars_path, notice: t('.created')
      else
        flash[:errors] = @car.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit; end

    def update
      redirect_to admin_cars_path, notice: t('.updated') and return if @car.update(permitted_params)

      render :edit
    end

    private

    def permitted_params
      params.require(:car).permit(:name, :condition, :dealership_id, :price)
    end

    def set_car
      @car = Car.find(params[:id])
    end

    def set_variables
      @conditions = Car.conditions.keys.map { |k| [Car.human_attribute_name(k), k] }
      @dealerships = Dealership.select(:id, :name)
    end
  end
end
