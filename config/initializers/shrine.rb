# frozen_string_literal: true

require 'cloudinary'
require 'shrine/storage/cloudinary'
Cloudinary.config(
  cloud_name: ENV.fetch('CLOUD_NAME', nil),
  api_key: ENV.fetch('CLOUD_API_KEY', nil),
  api_secret: ENV.fetch('CLOUD_API_SECRET', nil)
)
Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: 'images/cache'),
  store: Shrine::Storage::Cloudinary.new(prefix: 'images')
}
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
