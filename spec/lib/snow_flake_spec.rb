# frozen_string_literal: true

require 'rails_helper'
require 'snow_flake'

describe SnowFlake do
  let(:target_epoch) { Time.new(2023, 9, 19, 0, 0, 0).strftime('%s%L').to_i }
  subject(:snow_flake) { described_class.new(target_epoch:) }

  describe '#next_id' do
    it 'returns a unique snowflake ID' do
      expect(snow_flake.next_id).not_to eq(snow_flake.next_id)
    end

    it 'raises an OverflowError if the node ID is greater than or equal to 32' do
      expect { described_class.new(target_epoch:, node_id: 32) }.to raise_error(SnowFlake::OverflowError)
    end

    it 'raises an OverflowError if the datacenter ID is greater than or equal to 32' do
      expect { described_class.new(target_epoch:, datacenter_id: 32) }.to raise_error(SnowFlake::OverflowError)
    end

    it 'raises an OverflowError if the sequence is greater than or equal to 4096' do
      expect { described_class.new(target_epoch:, sequence: 4096) }.to raise_error(SnowFlake::OverflowError)
    end

    it 'raises an InvalidSystemClockError if the current time is less than the last time' do
      Timecop.freeze do
        snow_flake.next_id
        Timecop.travel(1.second.ago) do
          expect { snow_flake.next_id }.to raise_error(SnowFlake::InvalidSystemClockError)
        end
      end
    end
  end

  describe '#parse' do
    let(:snow_flake_id) { snow_flake.next_id }
    let(:hash) { snow_flake.parse(snow_flake_id) }

    it 'parses a snowflake ID into a hash' do
      Timecop.freeze do
        expect(hash[:epoch_time]).to eq(snow_flake.next_id >> (SnowFlake::SEQUENCE_BITS + SnowFlake::NODE_ID_BITS + SnowFlake::DATACENTER_ID_BITS))
        expect(hash[:time]).to eq(Time.at((hash[:epoch_time] + snow_flake.target_epoch) / 1000.0))
        expect(hash[:datacenter_id]).to eq(1)
        expect(hash[:node_id]).to eq(1)
        expect(hash[:sequence]).to eq(1)
      end
    end
  end
end
