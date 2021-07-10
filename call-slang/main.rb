require_relative '../slang/interpreter/interpreter'
require_relative '../slang/frontend/rd_parser'

class Main
  def run
    first()
    second()
  end

  def first
    str = "PRINTLINE 2*10;" + "\r\n" + "PRINTLINE 10;\r\n PRINT 2*10;\r\n";
    p = RDParser.new(str)

    statements = p.parse()
    statements.each do |statement|
      statement.accept(Interpreter.new)
    end
  end

  def second
    str = "PRINTLINE -2*10;" + "\r\n" + "PRINTLINE -10*-1;\r\n PRINT 2*10;\r\n";
    p = RDParser.new(str)

    statements = p.parse()
    statements.each do |statement|
      statement.accept(Interpreter.new)
    end
  end
end

m = Main.new
m.run