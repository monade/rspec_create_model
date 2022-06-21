# frozen_string_literal: true

RSpec::Matchers.define :create_model do |model_class|
  match(notify_expectation_failures: true) do |block|
    previous_elements = model_class.all.to_a
    block.call
    new_elements = model_class.all.to_a
    created_elements = new_elements - previous_elements
    if created_elements.any?
      block.binding.receiver.instance_variable_set(:@created_record, created_elements.first)
      block.binding.receiver.instance_variable_set(:@created_records, created_elements)
      true
    else
      false
    end
  end

  supports_block_expectations

  failure_message do |_|
    "Expected { } to create a new #{model_class}, but it didn't."
  end

  failure_message_when_negated do |_|
    "Expected { } not to create a new #{model_class}, but it did."
  end
end
