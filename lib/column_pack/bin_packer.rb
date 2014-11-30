module ColumnPack
  class BinPacker

    def initialize(total_bins, options = nil)
      @total_bins = total_bins
      options ||= {}

      @algorithm      = options[:algorithm]      || :best_fit_decreasing
      @shuffle_in_col = options[:shuffle_in_col] || true

      @elements       = []
      @needs_packing  = true
    end

    def add(size, content)
      @elements << {:size => size.to_i, :content => content}
      @needs_packing = true
    end

    def bins
      pack_all if @needs_packing
      @bins
    end

    def empty_space
      pack_all if @needs_packing
      max = @sizes.each.max
      space = 0
      @sizes.each { |size| space += max - size }
      return space
    end

    def sizes
      pack_all if @needs_packing
      @sizes
    end

    private
    def pack_all
      @bins   = Array.new(@total_bins) {Array.new}
      @sizes  = Array.new(@total_bins, 0)

      self.send(@algorithm)
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
        size, col = @sizes.each_with_index.min
        pack(col, element)
      end
    end

    def shuffle_within_cols
      @bins.each { |bin| bin.shuffle! }
    end

    def pack(col, element)
      @bins[col] << element[:content]
      @sizes[col] += element[:size].to_i
    end
  end
end
