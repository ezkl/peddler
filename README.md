# Peddler

[![travis][status]][travis]

![Peddler][mussels]

Peddler wraps the [Amazon Marketplace Web Service (MWS) APIs][mws].

## Usage

```ruby
client = Peddler.new 'US'

client.configure do |c|
  c.key       = 'key'
  c.secret    = 'secret'
  c.seller_id = 'seller_id'
end
```

[status]: https://secure.travis-ci.org/hakanensari/peddler.png
[travis]: http://travis-ci.org/hakanensari/peddler
[mussels]: http://f.cl.ly/items/0W3V0A1Z110Q0x461b3H/mussels.jpeg
[mws]: https://developer.amazonservices.com/gp/mws/docs.html
