require_relative 'multiplication_table'
require_relative 'table_printer'
require 'io/console'

class Cli
  def run(args)
    num = determine_number_of_primes(args)
    return unless num > 0

    output_table(num)
  end

  def output_table(num)
    table = MultiplicationTable.new.generate(num)
    printer = TablePrinter.new(table)
    max = max_number_of_primes_for_screen(printer.max_cell_width)
    str = (num > max) ? not_enough_real_estate(num, max) : printer.output
    output str
  end

  def max_number_of_primes_for_screen(cell_width)
    (window_width / cell_width) - 1
  end

  def window_width
    IO.console.winsize[1]
  end

  def output(str)
    print "\n"
    print str
    print "\n"
  end

  def determine_number_of_primes(args = [])
    num = 10
    if args.count > 0
      num = args[0].to_i
      output warning(args[0]) if num <= 0
    end
    num
  end

  def warning(input)
    str = "You asked for a table of '#{input}' elements.\n"
    str << "That doesn't really make sense.\n"
    str << "Please try again with a different number."
    str
  end

  def not_enough_real_estate(num, max)
    str = "You asked for a table of '#{num}' elements.\n"
    str << "However your screen can only handle up to #{max} elements.\n"
    str << "Please try again with a number less than or equal to #{max}."
    str
  end
end