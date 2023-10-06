# frozen_string_literal: true

require 'rails_helper'
require 'short_code'

describe ShortCode do
  describe '.encode' do
    it "from 0 to '0'" do
      expect(described_class.encode(0)).to eq('0')
    end

    it "from 1 to '1'" do
      expect(described_class.encode(1)).to eq('1')
    end

    it "from 10 to 'a'" do
      expect(described_class.encode(10)).to eq('a')
    end

    it "from 62 to '10'" do
      expect(described_class.encode(62)).to eq('10')
    end

    it "from 1024 to 'gw'" do
      expect(described_class.encode(1024)).to eq('gw')
    end

    it "from 999_999 to '4c91'" do
      expect(described_class.encode(999_999)).to eq('4c91')
    end
  end

  describe ".decode" do
    it "from '0' to 0" do
      expect(described_class.decode('0')).to eq(0)
    end

    it "from '1' to 1" do
      expect(described_class.decode('1')).to eq(1)
    end

    it "from 'a' to 10" do
      expect(described_class.decode('a')).to eq(10)
    end

    it "from '10' to 62" do
      expect(described_class.decode('10')).to eq(62)
    end

    it "from 'gw' to 1024" do
      expect(described_class.decode('gw')).to eq(1024)
    end

    it "from '4c91' to 999_999" do
      expect(described_class.decode('4c91')).to eq(999_999)
    end
  end
end
