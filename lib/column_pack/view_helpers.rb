module ColumnPack
  module ViewHelpers

    # Packs content into columns.
    #
    # pack_in_columns expect a block to be passed:
    #
    #   pack_in_columns(3) do
    #     pack_element(100) do
    #       "A"
    #     end
    #  end
    #
    # Options:
    # :algorithm        specify a different bin packing algorithm (default :best_fit_decreasing)
    #                   available algorithms are :best_fit_decreasing, :best_fit_increasing
    #
    # :shuffle_in_col   after packing columns, shuffle the elements in each column (defaults to true)
    #
    def pack_in_columns(total_columns, options = {})
      @column_packer = ColumnPacker.new(total_columns, options)

      yield

      @column_packer.render
    end

    # Packs a single element with a given height into a column.
    #
    # pack_element should be called withing pack_in_columns's block:
    #
    #   pack_in_columns(3) do
    #     pack_element(100) do
    #       "A"
    #     end
    #  end
    #
    # Accepts parameter strings or block content (ERB, strings, etc).
    #
    def pack_element(height, content = nil, &block)
      return if @column_packer.nil?

      if block_given?
        @column_packer.add(height.to_i, capture(&block))
      else
        @column_packer.add(height.to_i, content)
      end
    end

  end
end
