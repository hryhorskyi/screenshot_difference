# frozen_string_literal: true

class CreateDifferences < ActiveRecord::Migration[7.0]
  def change
    create_table :differences do |t|
      t.string :original_data
      t.string :edited_data
      t.string :difference_data

      t.timestamps
    end
  end
end
