# column_pack [![Build Status](https://travis-ci.org/justintanner/column_pack.svg?branch=master)](https://travis-ci.org/justintanner/column_pack)

Evenly arranges content into a fixed number of columns.

Useful in creating [pinterest](http://www.pinterest.com) style image murals.

Example of **17 images** arranged into **5 columns**.

![example image](http://i.imgur.com/ts69lmj.jpg)

Note: each image has a fixed width of 150 pixels.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'column_pack'
```

Add the following line to `app/assets/stylesheets/application.css`

```
//= require column_pack
```

## Usage

Pack some text into three columns:

```erb
<%= pack_in_columns(3) do |bag| %>

  <%= bag.add 100, 'A' %>
  <%= bag.add 300, 'B' %>
  <%= bag.add 50,  'C' %>
  <%= bag.add 350, 'D' %>
  <%= bag.add 200, 'E' %>
  <%= bag.add 200, 'F' %>

<%= end %>
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

## Styling the Columns

The size of the container and spacing between columns **requires css styling**.

The following example creates **three 300px** columns with **10px** spacing:

```css
.column-pack-wrap {
  width: 930px;
}

.column-pack-col {
  width: 300px;
  margin: 0 5px 0 5px;
}

.column-pack-element {
  margin: 0 0 10px 0;
}
```

## Additional Options

**Signature**

```ruby
pack_in_columns(total_cols, options = {})
```

**Options**

* `:algorithm` - specify a different bin packing algorithm (default is `:best_fit_decreasing`)
* `:shuffle_in_cols` - after packing columns, shuffle the elements in each column (default is
  `true`)

## Contributing

1. Fork it ( https://github.com/justintanner/column_pack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
