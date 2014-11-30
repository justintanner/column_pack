# column_pack

A gem to organize elements into columns.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'column_pack'
```

Add the following lines to `app/assets/stylesheets/application.css`:

```
//= require column_pack
```

## Usage

Pack some text into three columns:

```ruby
pack_in_columns(3) do |bag|

  bag.add 100, 'A'
  bag.add 300, 'B'
  bag.add 50,  'C'
  bag.add 350, 'D'
  bag.add 200, 'E'
  bag.add 200, 'F'

end
```

Pack some images into five columns:

```erb
<%= pack_in_columns(5) do |bag| %>

  <% @images.each do |image| %>
    <% bag.add(image.height) do %>
      <%= image_tag image.url %>
   <% end %>
  <% end %>

<% end %>
```


## Customizing CSS


## Contributing

1. Fork it ( https://github.com/[my-github-username]/column_pack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
