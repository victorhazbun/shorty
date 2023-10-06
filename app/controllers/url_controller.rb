require 'snow_flake'

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
    target_epoch = Time.new(2023, 9, 19, 0, 0, 0).strftime('%s%L').to_i
    SnowFlake.new(target_epoch:).next_id
  end
end
