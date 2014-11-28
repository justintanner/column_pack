module ColumnPack
  class BinPacker

    def initialize(total_bins, algorithm = :best_fit_increasing)
      @total_bins    = total_bins
      @algorithm     = algorithm
      @elements      = []
      @needs_packing = true
    end

    def add(size, content=yield)
      @elements << {:size => size.to_i, :content => content}
      @needs_packing = true
    end

    def [](key)
      pack_all if @needs_packing
      @bins[key]
    end

    def each
      pack_all if @needs_packing
      @bins
    end

    def length
      pack_all if @needs_packing
      @bins.length
    end

    def to_s
      pack_all if @needs_packing
      @bins.to_s
    end

    def sizes
      pack_all if @needs_packing
      @sizes
    end

    def empty_space
      pack_all if @needs_packing
      max = @sizes.each.max
      space = 0
      @sizes.each { |size| space += max - size }
      return space
    end

    private
    def pack_all
      @bins   = Array.new(@total_bins) {Array.new}
      @sizes  = Array.new(@total_bins, 0)

      self.send(@algorithm)
      shuffle_cols

      @needs_packing = false
    end

    def best_fit_decreasing
      @elements.sort_by{ |e| e[:size] }.reverse!
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

    def shuffle_cols
      @bins.each do |bin|
        bin.shuffle!
      end
    end

    def pack(col, element)
      @bins[col] << element[:content]
      @sizes[col] += element[:size].to_i
    end
  end
end
