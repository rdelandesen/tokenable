# Tokenable

Tokenable allows you to generate unique tokens on **[ActiveRecord model](http://guides.rubyonrails.org/active_record_basics.html)** attributes.

Tokenable supports **[SecureRandom](http://ruby-doc.org/stdlib-2.1.2/libdoc/securerandom/rdoc/SecureRandom.html)** methods :

- base64
- urlsafe_base64
- hex
- random_bytes
- random_number
- uuid

Generation can be triggered **[manually](#manually)** and / or with an **[ActiveRecord Callback](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)**.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tokenable', github: 'rdelandesen/tokenable'
```

And then execute:

    $ bundle

## Usage

### Model setup

```ruby
class User < ActiveRecord::Base
  tokenable.config do |c|
    c.attr     = :token
    c.n        = 42 # length in bytes
    c.meth0d   = :urlsafe_base64
    c.callback = :before_create
  end
end
```

### <a name="manually">Manually generate</a>
```ruby
user = User.new
user.tokenable.generate
user.token
# => "Zx7E92QSldsjiFnu9PWCtHkwbpR"
```

### Multiple attributes
```ruby
class User < ActiveRecord::Base
  tokenable.config do |c|
    # [...]
    c.attrs = %i(token secure_id)
  end
end
```

### Random length (in bytes)
```ruby
class User < ActiveRecord::Base
  tokenable.config do |c|
    # [...]
    c.attrs = %i(token secure_id)
    c.n = 10..22
  end
end
```
**This will apply a random length on each attribute :**

```ruby
user = User.new
user.tokenable.generate
user.token
# => "w6qLICRtZYShB9ZBkAX-Dvxx"
user.secure_id
# => "jtj6JNDOOLZP-asWZQ"
```


### Random method
```ruby
class User < ActiveRecord::Base
  tokenable.config do |c|
    # [...]
    c.attrs = %i(token secure_id)
    c.meth0d = %w(urlsafe_base64 uuid)
  end
end
```
**This will apply a random method on each attribute :**

```ruby
user = User.new
user.tokenable.generate
user.token
# => "w6qLICRtZYShB9ZBkAX" # urlsafe_base64
user.secure_id
# => "7a440004c9b1b1797cf211da54c2c641" # UUID
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rdelandesen/tokenable.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

