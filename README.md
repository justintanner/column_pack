# column_pack

Arranges content into *fixed number of columns* using a bin packing algorithm.

Example of 17 images (each 150px wide) arranged into 5 columns:

![example image](http://i.imgur.com/ts69lmj.jpg)

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

The size of the column container and spacing between should be be styled to match the content.

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

* `:algorithm` - specifiy a different bin packing algorithm (default is `:best_fit_decreasing`)
* `:shuffle_in_cols` - after packing columns, shuffle the elements in each column (default is `true`)

## Contributing

1. Fork it ( https://github.com/justintanner/column_pack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
