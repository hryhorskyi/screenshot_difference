# frozen_string_literal: true

require 'image_uploader'

class Screenshot < ApplicationRecord
  include ImageUploader::Attachment(:image)
end
