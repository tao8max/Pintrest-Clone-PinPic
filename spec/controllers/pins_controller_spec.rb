require 'rails_helper'

RSpec.describe PinsController, :type => :controller do

	before (:each) do
	  user = User.create!({
	    :email => 'user@test.com',
	    :password => 'password123',
	    :password_confirmation => 'password123' 
	    })
	  sign_in user
	end


	let(:valid_session) do {
		pin_id: 1}
	end

	let(:valid_attributes) do {
		title: "Hello",
		description: "this is my first post",
		user_id: 1,
		created_at: "2015-11-10 18:06:46",
		image_file_name: "11186942_838208842914343_1032754810_n.jpg",
		image_content_type: "image/jpeg",
		image_file_size: 164456,
		image_updated_at: "2015-11-02 03:10:39"
	}
	end

	let(:invalid_attributes) do {
		title: nil,
		description: "this is my first post",
		user_id: 1,
		created_at: "2015-11-10 18:06:46",
		image_file_name: "11186942_838208842914343_1032754810_n.jpg",
		image_content_type: "image/jpeg",
		image_file_size: 164456,
		image_updated_at: "2015-11-02 03:10:39"
	}
	end

	describe "GET index" do
		it "assigns all pins to @pins" do
			pin=Pin.create! valid_attributes
			get :index, {}, valid_session
			expect(assigns(:pins)).to eq([pin])
		end
	end

	describe "GET show" do
		it "assigns the requested pin as @pin" do
			pin=Pin.create! valid_attributes
			get :show, {id: pin.id}, valid_session
			expect(assigns(:pin)).to eq(pin)
		end
	end

	describe "GET new" do
		it "assigns a new pin as @pin" do
			get :new, {}, valid_session
			expect(assigns(:pin)).to be_instance_of(Pin)
		end
	end

	describe "POST create" do
	  context "when valid attributes" do
		  it "creates the requested pin as @pin" do
		   	post :create, {pin: valid_attributes}, valid_session
		   	expect(Pin.find_by_title(valid_attributes[:title])).to be_present
		  end
			
			it "assigns the requested pin as @pin" do
		   	post :create, {pin: valid_attributes}, valid_session
		   	expect(assigns(:pin)).to eq(Pin.find_by_title(valid_attributes[:title]))
		  end
			
			it "redirects to specific pin" do
			  post :create, {pin: valid_attributes}, valid_session
			  expect(response).to redirect_to assigns(:pin)
			end
		end

		context "when invalid attributes" do
			render_views
			it "does not create requested pin" do
				post :create, {pin: invalid_attributes}, valid_session
				expect(Pin.find_by_title(valid_attributes[:title])).to be_nil
			end

			it "renders the new template" do
				post :create, {pin: invalid_attributes}, valid_session
				expect(response).to render_template(:new)
			end
		end
  end	   			
end
