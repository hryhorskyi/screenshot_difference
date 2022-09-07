# frozen_string_literal: true

require 'image_uploader'

class Difference < ApplicationRecord
  include ImageUploader::Attachment(:original)
  include ImageUploader::Attachment(:edited)
end
