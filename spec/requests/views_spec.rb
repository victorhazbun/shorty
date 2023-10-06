require 'rails_helper'

RSpec.describe 'Views', type: :request do
  before do
    allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache.lookup_store(:memory_store))
    Rails.cache.clear
  end

  describe 'GET /v/:id' do
    let!(:url) { Url.create!(short: 'short', long: 'https://www.example.com') }

    context 'when the short URL is valid' do
      it 'returns the long URL' do
        get "/v/#{url.short}"

        long_url = JSON.parse(response.body)['long']

        expect(response).to have_http_status(:ok)
        expect(long_url).to eq(url.long)
        expect(Rails.cache.read("url:#{url.short}")).to eq(url.long)
      end
    end

    context 'when the short URL is invalid' do
      it 'returns a 404 error' do
        get "/v/#{url.short.reverse}"

        errors = JSON.parse(response.body)['errors']
        expect(response).to have_http_status(:not_found)
        expect(errors).to eq('Not found')
      end
    end
  end
end
