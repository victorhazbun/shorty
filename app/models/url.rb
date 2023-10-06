# frozen_string_literal: true

class Url < ApplicationRecord
  validates :short, presence: true
  validates :long, presence: true, uniqueness: true
end
