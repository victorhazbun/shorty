class CreateUrl
  def self.call(short:, long:)
    url = Url.where(long:).last

    return url if url.present?

    url = Url.create(short:, long:)
    Rails.cache.write("url:#{short}", url.long) if url.valid?
    url
  end
end
