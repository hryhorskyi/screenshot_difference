# frozen_string_literal: true

json.extract! screenshot, :id, :url, :created_at, :updated_at, :image_data
json.url screenshot_url(screenshot, format: :json)
