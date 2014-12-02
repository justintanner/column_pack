module ColumnPack
  module ViewHelpers

    def pack_in_columns(total_columns, options = {})
      cp = ColumnPacker.new(total_columns, options)

      yield(cp)

      cp.render
    end

    def p1
      @test = String.new
      yield(@test)
    end

    def p2(test, height, content = nil, &block)
      if block_given?
        test.concat capture(&block)
      else
        test.concat content
      end
    end

    def p3
      @test.html_safe
    end
  end
end
