# frozen_string_literal: true

require "spec_helper"

RSpec.describe "RspecCreateModel" do
  it "Matches the created record" do
    expect { Mug.create!(color: "#000000", capacity: 1.50) }.to create_model Mug
  end
end
