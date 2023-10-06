require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:short) { 'a1c2b3' }
  let(:long) { 'https://shorty.com/a1c2b3' }
  subject(:url) { described_class.new(short:, long:) }

  context 'when short URL is missing' do
    let(:short) { '' }
    it 'has errors' do
      expect(url.valid?).to be(false)
      expect(url.errors[:short]).to include("can't be blank")
    end
  end

  context 'when long URL is missing' do
    let(:long) { '' }
    it 'has errors' do
      expect(url.valid?).to be(false)
      expect(url.errors[:long]).to include("can't be blank")
    end
  end

  context 'when long URL is not unique' do
    subject(:new_url) { described_class.new(short:, long:) }
    before { url.save! }

    it 'has errors' do
      expect(new_url.valid?).to be(false)
      expect(new_url.errors[:long]).to include("has already been taken")
    end
  end
end
