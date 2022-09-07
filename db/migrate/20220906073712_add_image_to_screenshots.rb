# frozen_string_literal: true

class AddImageToScreenshots < ActiveRecord::Migration[7.0]
  def change
    add_column :screenshots, :image_data, :string
  end
end
