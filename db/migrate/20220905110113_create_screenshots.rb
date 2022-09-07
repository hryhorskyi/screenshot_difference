# frozen_string_literal: true

class CreateScreenshots < ActiveRecord::Migration[7.0]
  def change
    create_table :screenshots do |t|
      t.string :url

      t.timestamps
    end
  end
end
