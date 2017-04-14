require 'rails_helper'

RSpec.describe 'Bookings API', type: :request do
  before :each do          
    @rental = FactoryGirl.create(:rental)
  end
  
  let!(:booking) { FactoryGirl.create(:booking, :rental => @rental) }

  describe 'GET /bookings' do
    before { get '/rentals/1/bookings', {api_token: "j6hd9@l664HDv2agh"} }

    it 'returns bookings' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /bookings' do
    let(:valid_attributes)   { {api_token: "j6hd9@l664HDv2agh", start_at: "2017-07-19", end_at: "2017-07-20", price: 120.0 } }
    let(:invalid_attributes) { {api_token: "j6hd9@l664HDv2agh", start_at: "2017-07-191", end_at: "2017-07-20", price: 120.0 } }

    context 'when the request is valid' do
      before { post '/rentals/1/bookings', params: valid_attributes }

      it 'creates a booking' do
        expect(json['start_at']).to eq("2017-07-19T00:00:00.000Z")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/rentals/1/bookings', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: /)
      end
    end
  end

  describe 'PUT /bookings/:id' do
    let(:valid_attributes) { { start_at: "2017-06-19", end_at: "2017-f6-20", price: 1240.0 } }

    context 'when the record exists' do
      before { put "/rentals/1/bookings/#{booking.id}", {api_token: "j6hd9@l664HDv2agh"}, params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /bookings/:id' do
    before { delete "/rentals/1/bookings/#{booking.id}", {api_token: "j6hd9@l664HDv2agh"} }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
