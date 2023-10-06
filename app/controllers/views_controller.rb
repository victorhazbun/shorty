# frozen_string_literal: true

# @note To read
class ViewsController < ApplicationController
  def show
    long = Rails.cache.fetch("url:#{params[:id]}") do
      Url.where(short: params[:id]).last&.long
    end

    if long
      render json: { long: long }, status: :ok
    else
      render json: { errors: 'Not found' }, status: :not_found
    end
  end
end
