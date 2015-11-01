class PinsController < ApplicationController
	def index
	end

	def show
		@pin=Pin.find(params[:id])
	end

	def new
		@pin=Pin.new
	end

	def create
		@Pin.new(pin_params)
		if @pin.save
			redirect_to @pin, notice: "Your new pin was successfully created."
		else
			render :new
		end
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description)
	end
end
