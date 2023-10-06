# frozen_string_literal: true

# @note To read
class SnowFlake
  TIMESTAMP_BITS = 41
  NODE_ID_BITS   = 5
  DATACENTER_ID_BITS = 5
  SEQUENCE_BITS = 12

  MAX_NODE_ID = (1 << NODE_ID_BITS) # 1024
  MAX_DATACENTER_ID = (1 << DATACENTER_ID_BITS) # 1024
  MAX_SEQUENCE = (1 << SEQUENCE_BITS) # 4096

  attr_accessor :target_epoch

  def initialize(target_epoch: Time.now.strftime('%s%L').to_i, datacenter_id: 1, node_id: 1, sequence: 0)
    raise OverflowError, "invalid node_id (#{node_id} >= #{MAX_NODE_ID})" if node_id >= MAX_NODE_ID
    if datacenter_id >= MAX_DATACENTER_ID
      raise OverflowError, "invalid datacenter_id (#{datacenter_id} >= #{MAX_DATACENTER_ID})"
    end
    raise OverflowError, "invalid sequence (#{sequence} >= #{MAX_SEQUENCE})" if sequence >= MAX_SEQUENCE

    @target_epoch = target_epoch
    @node_id = node_id % MAX_NODE_ID
    @datacenter_id = datacenter_id % MAX_DATACENTER_ID
    @sequence = sequence % MAX_SEQUENCE
    @last_time = current_time
  end

  def next_id
    time = current_time

    raise InvalidSystemClockError, "(#{time} < #{@last_time})" if time < @last_time

    @sequence = time == @last_time ? (@sequence + 1) % MAX_SEQUENCE : 0

    @last_time = time

    compose(@last_time, @datacenter_id, @node_id, @sequence)
  end

  private

  def compose(last_time, datacenter_id, node_id, sequence)
    ((last_time - @target_epoch) << (SEQUENCE_BITS + NODE_ID_BITS + DATACENTER_ID_BITS)) +
      (datacenter_id << (SEQUENCE_BITS + DATACENTER_ID_BITS)) +
      (node_id << SEQUENCE_BITS) +
      sequence
  end

  def current_time
    Time.now.strftime('%s%L').to_i
  end
end

class SnowFlake::OverflowError < StandardError; end
class SnowFlake::InvalidSystemClockError < StandardError; end
