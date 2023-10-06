# frozen_string_literal: true

require 'snow_flake'
require 'short_code'

# @note To read
class UrlController < ApplicationController
  def create
    url = CreateUrl.call(short:, long: params[:long])
    if url.valid?
      render json: url, status: :created
    else
      render json: { errors: url.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private

  def short
    ShortCode.encode(SnowFlake.new.next_id)
  end
end
