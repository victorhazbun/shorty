require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /url' do
    let(:long) { 'https://www.example.com' }

    context 'when the long URL is valid' do
      it 'creates a new URL record and returns it' do
        post '/url', params: { long: }

        expect(response).to have_http_status(:created)

        url = JSON.parse(response.body)
        expect(url['short'].length).to eq(9)
        expect(url['long']).to eq(long)
      end
    end

    context 'when the long URL is invalid' do
      it 'returns an error message' do
        post '/url', params: { long: '' }

        expect(response).to have_http_status(:bad_request)

        error_message = JSON.parse(response.body)

        expect(error_message['errors']).to eq('Long can\'t be blank')
      end
    end
  end
end
