![Tests](https://github.com/monade/rspec_create_model/actions/workflows/test.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/rspec_create_model.svg)](https://badge.fury.io/rb/rspec_create_model)

# rspec_create_model

A rspec matcher for Rail's ActiveRecord, to check the type of models created from actions.

## Installation

Add the gem to your Gemfile

```ruby
  gem 'rspec_create_model'
```

## Example usage

Given the following records:

```ruby
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
```

You can match created records like this:

```ruby
expect { Author.create!(name: "Some author name") }.to create_model(Author)

expect { Author.create!(name: "Some author name") }
  .to create_model(Author)
  .and create_model(Book)
```

When the matcher is called, 2 instace variable get set: **@created_record** and **@created_records**

these variables includes the newly created records. You can also use them if you want, like this:

```ruby
expect { Author.create!(name: "Some author name") }.to create_model(Author)

expect(@created_record).to be_a(Author)
expect(@created_records).to all(be_a(Author))
```

including the created records, you also could write tests on their content.

Remember to checkout the Gem's specs to see how to use it!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

About Monade
----------------

![monade](https://monade.io/wp-content/uploads/2021/06/monadelogo.png)

rspec_create_model is maintained by [mònade srl](https://monade.io/en/home-en/).

We <3 open source software. [Contact us](https://monade.io/en/contact-us/) for your next project!
