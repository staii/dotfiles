Pry.config.print = proc do |output, value|
  begin
    insp = value.inspect
    if insp.length > Pry::Terminal.width! * Pry::Terminal.height!
      output.puts insp
    else
      io = StringIO.new
      Pry::ColorPrinter.pp(value, io, Pry::Terminal.width! - 1)
      io.rewind
      res = io.read
      if res.count("\n") < Pry::Terminal.height!
        # For some reason, printing res to output can hang for big output, so
        # rerun the color printer on the output instead.
        Pry::ColorPrinter.pp(value, output, Pry::Terminal.width! - 1)
      else
        output.puts insp
      end
    end
  rescue Pry::RescuableException
    output.puts "<unknown>"
  end
end
