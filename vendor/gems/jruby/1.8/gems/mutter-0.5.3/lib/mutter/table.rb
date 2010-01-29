module Mutter
  class Table
    attr_accessor :rows, :columns

    DefaultTable = {
      :delimiter => " ",
      :truncater => ".."
    }
    DefaultColumn = {
      :align  => :left,
      :style  => []
    }

    def initialize options = {}, &blk
      @columns, @rows = [], []
      @options = DefaultTable.merge options

      instance_eval(&blk) if (@fixed = block_given?)
    end

    def fixed?; @fixed end

    def column options = {}
      @columns << DefaultColumn.merge(options)
    end

    def << row
      if row.size > @columns.size && fixed?
        raise ArgumentError,
          "row size is #{row.size} but I only have #{@columns.size} columns"
      else
        @rows << row
      end
    end

    def render
      # Create missing columns as needed
      (@rows.map {|r| r.size }.max - @columns.size).times do
        self.column
      end

      # Compute max column width
      @columns.each_with_index do |col, i|
        col[:_width] = @rows.map do |r|
          r[i].to_s.length
        end.max if @rows[i]
      end

      # print table
      @rows.map do |row|
        @columns.zip(row).map do |col, cell|
          process(cell.to_s || "",
                  col[:width] || col[:_width],
                  col[:align],
                  col[:style])
        end.join @options[:delimiter]
      end
    end
    alias :to_a render

    def to_s
      render.join("\n")
    end

    def print
      puts render
    end

    def process str, length = nil, align = :left, style = []
      length ||= str.length

      if str.length > length
        str[0...(length - @options[:truncater].length)] + @options[:truncater]
      else
        s = [Mutter.new.clear.process(str, style), ' ' * (length - str.length)]
        s.reverse! if align == :right
        s.join
      end
    end
  end
end
