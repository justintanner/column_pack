# column_pack [![Build Status](https://travis-ci.org/justintanner/column_pack.svg?branch=master)](https://travis-ci.org/justintanner/column_pack)

Arranges content into a fixed number of columns.

Useful in creating [pinterest](http://www.pinterest.com) style image murals.

If you are looking for a JavaScript solution try: [packery][1], [masonry][2] or [isotope][3].

## Example

**17 images** arranged into **5 columns**.

![example image](http://i.imgur.com/deSRVox.jpg)

(150px wide images)

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
<%= pack_in_columns(3) do %>

  <%= pack_element 100, 'A' %>
  <%= pack_element 300, 'B' %>
  <%= pack_element 50,  'C' %>
  <%= pack_element 350, 'D' %>
  <%= pack_element 200, 'E' %>
  <%= pack_element 200, 'F' %>

<%= end %>
```

Pack some images into five columns:

```erb
<%= pack_in_columns(5) do %>
  <% @images.each do |image| %>

   <% pack_element(image.height) do %>
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

[1]: https://github.com/metafizzy/packery
[2]: https://github.com/desandro/masonry
[3]: https://github.com/metafizzy/isotope
