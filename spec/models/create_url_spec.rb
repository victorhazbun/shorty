require 'rails_helper'

describe CreateUrl, type: :service, with_cache: true do
  let(:short) { 'short' }
  let(:long) { 'long' }

  before do
    allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache.lookup_store(:memory_store))
    Rails.cache.clear
  end

  describe '.call' do
    context 'when a URL record with the given long URL exists' do
      let!(:url) { Url.create!(short:, long:) }

      it 'returns the existing URL record' do
        expect(described_class.call(short:, long:)).to eq(url)
      end
    end

    context 'when a URL record with the given long URL does not exist' do
      it 'creates a new URL record' do
        expect { described_class.call(short:, long:) }.to change(Url, :count).by(1)
      end

      it 'caches the long URL' do
        described_class.call(short:, long:)

        expect(Rails.cache.read('url:short')).to eq('long')
      end

      it 'returns the new URL record' do
        url = described_class.call(short:, long:)

        expect(url.short).to eq('short')
        expect(url.long).to eq('long')
      end

      context 'and the URL is invalid' do
        it 'does not caches the long URL' do
          described_class.call(short: '', long:)

          expect(Rails.cache.read('url:')).to be_nil
        end
      end
    end
  end
end
