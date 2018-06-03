class TablePrinter
  attr_reader :table, :max_cell_width

  # @param [Array<Array<Integer>>] table
  def initialize(table)
    @table = table
    @max_cell_width = determine_max_cell_width
  end

  def determine_max_cell_width
    cell_width(table.last.last)
  end
  private :determine_max_cell_width

  def cell_width(num)
    num.to_s.length + 1
  end
  private :cell_width

  def output
    arr = []
    table.each_with_index do |row, i|
      arr << row(row, i.zero?)
    end
    arr.join("\n")
  end

  def row(row, header_row = false)
    str = header_row ? pad(' ') : ''
    row.each { |num| str << pad(num) }
    str
  end
  private :row

  def pad(num)
    num.to_s.center(max_cell_width)
  end
  private :pad
end