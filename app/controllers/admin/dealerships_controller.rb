# frozen_string_literal: true

module Admin
  class DealershipsController < ApplicationController
    before_action :set_dealership, only: %i[edit update destroy]

    def index
      @dealerships = Dealership.all
    end

    def new
      @dealership = Dealership.new
    end

    def create
      @dealership = Dealership.new(permitted_params)

      if @dealership.save
        redirect_to admin_dealerships_path, notice: t('.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @dealership.update(permitted_params)
        redirect_to admin_dealerships_path, notice: t('.updated')
      else
        flash[:error] = @dealership.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      redirect_to admin_dealerships_path, notice: t('.deleted') if @dealership.destroy
    end

    private

    def permitted_params
      params.require(:dealership).permit(:name)
    end

    def set_dealership
      @dealership = Dealership.find(params[:id])
    end
  end
end
