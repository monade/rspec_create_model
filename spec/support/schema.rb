# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

class Mug < ActiveRecord::Base
  attribute :capacity, type: :Float
  attribute :color, type: :String
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :mugs, force: true do |t|
        t.decimal :capacity
        t.string :color

        t.timestamps null: false
      end
    end
  end
end
