# frozen_string_literal: true

class CreateRoutines < ActiveRecord::Migration[7.0]
  def change
    create_table :routines do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
