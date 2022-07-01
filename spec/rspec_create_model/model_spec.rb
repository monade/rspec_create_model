# frozen_string_literal: true

require "spec_helper"

RSpec.describe "RspecCreateModel" do
  it "Matches the created record" do
    expect { Author.create!(name: "Friedrich Nietzsche") }.to create_model Author
  end

  it "Matches the created record in callback" do
    expect { Author.create!(name: "Friedrich Nietzsche") }
      .to create_model(Author)
      .and create_model(Book)
  end

  it "Created records are avaialable through instance variables" do
    expect { Author.create!(name: "Friedrich Nietzsche") }
      .to create_model(Author)

    expect(@created_record).not_to be(nil)
    expect(@created_records).not_to be(nil)

    expect(@created_record).to be_a(Author)
    expect(@created_records).to be_a(Array)

    expect(@created_records.first).to be_a(Author)
  end

  it "Instance variables match the model we are examinating" do
    expect { Author.create!(name: "Friedrich Nietzsche") }.to create_model(Author)

    expect(@created_record).to be_a(Author)
    expect(@created_records).to all(be_a(Author))

    expect { Author.create!(name: "Friedrich Nietzsche") }.to create_model(Book)

    expect(@created_record).to be_a(Book)
    expect(@created_records).to all(be_a(Book))
  end
end
