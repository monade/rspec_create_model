# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

class Author < ActiveRecord::Base
  attribute :name, type: :String
  has_many :articles, dependent: :destroy

  after_create :create_empty_book

  def create_empty_book
    Book.create!(author_id: id, title: "First Empty Book")
  end
end

class Book < ActiveRecord::Base
  belongs_to :author, optional: false
  attribute :title, type: :String
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :authors, force: true do |t|
        t.decimal :name

        t.timestamps null: false
      end

      create_table :books, force: true do |t|
        t.belongs_to :author, foreign_key: true, on_delete: :cascade
        t.string :title

        t.timestamps null: false
      end
    end
  end
end
