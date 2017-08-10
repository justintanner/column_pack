module ColumnPack

  # Arranges elements into bins using a simple one dimensional bin packing algorithm.
  class BinPacker

    # Uses a fixed number of bins (total_bins).
    #
    # Options:
    # :algorithm        specify a different bin packing algorithm (default :best_fit_decreasing)
    #                   available algorithms are :best_fit_decreasing, :best_fit_increasing
    #
    # :shuffle_in_col   after packing columns, shuffle the elements in each column (defaults to true)
    #
    def initialize(total_bins, options = {})
      raise ArgumentError.new("Must choose a number of bins greater than zero") if total_bins <= 0

      @total_bins = total_bins
      @algorithm  = options[:algorithm] || :best_fit_decreasing

      if options.has_key? :shuffle_in_col
        @shuffle_in_col = options[:shuffle_in_col]
      else
        @shuffle_in_col = true
      end

      @elements       = []
      @needs_packing  = true
    end

    # Adds element to be packed.
    def add(size, content)
      raise ArgumentError.new("Bin size must be greater than zero") if size <= 0

      @elements << {:size => size.to_i, :content => content}
      @needs_packing = true
    end

    # Returns a packed multi-dimensional array of elements.
    def bins
      pack_all if @needs_packing
      @bins
    end

    # Total empty space left over by uneven packing.
    def empty_space
      pack_all if @needs_packing
      max = @sizes.each.max
      space = 0

      @sizes.each { |size| space += max - size }

      space
    end

    private
    def pack_all
      @bins   = Array.new(@total_bins) {Array.new}
      @sizes  = Array.new(@total_bins, 0)

      self.send(@algorithm)
      tall_to_middle
      shuffle_within_cols if @shuffle_in_col

      @needs_packing = false
    end

    def best_fit_decreasing
      @elements.sort_by! { |e| e[:size] }
      @elements.reverse!
      best_fit
    end

    def best_fit_increasing
      @elements.sort_by! { |e| e[:size] }
      best_fit
    end

    def best_fit
      @elements.each do |element|
        _, col = @sizes.each_with_index.min
        pack(col, element)
      end
    end

    def shuffle_within_cols
      @bins.each { |bin| bin.shuffle! }
    end

    # moves the tallest bin to the middle
    def tall_to_middle
      if (@total_bins > 1) && ((@total_bins % 2) != 0)
        _, max_col = @sizes.each_with_index.max
        mid_col = @total_bins / 2

        temp = @bins[mid_col].clone
        @bins[mid_col] = @bins[max_col]
        @bins[max_col] = temp
      end
    end

    def pack(col, element)
      @bins[col] << element[:content]
      @sizes[col] += element[:size].to_i
    end
  end
end
