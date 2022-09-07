# frozen_string_literal: true

json.extract! difference, :id, :original_data, :edited_data, :difference, :created_at, :updated_at
json.url difference_url(difference, format: :json)
