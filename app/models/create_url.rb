# frozen_string_literal: true

# @note To read
class CreateUrl
  # Creates a new URL or returns an existing URL if it already exists.
  #
  # @param short [String] The short code for the URL.
  # @param long [String] The long URL.
  # @return [Url] The created or found URL.
  # @note Cache the long URL using the short ID unless the URL model is invalid.
  def self.call(short:, long:)
    url = Url.where(long:).last

    return url if url.present?

    url = Url.create(short:, long:)
    Rails.cache.write("url:#{short}", url.long) if url.valid?
    url
  end
end
