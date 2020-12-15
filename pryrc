Pry.config.print = proc do |output, value|
  begin
    io = StringIO.new
    Pry::ColorPrinter.pp(value, io, Pry::Terminal.width! - 1)
    io.rewind
    res = io.read
    if res.count("\n") < Pry::Terminal.height!
      output.puts res
    else
      output.puts value.inspect
    end
  rescue RescuableException
    output.puts "<unknown>"
  end
end
