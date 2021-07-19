require_relative '../slang/interpreter/interpreter'
require_relative '../slang/frontend/rd_parser'
require_relative '../slang/contexts/compilation_context'
require_relative '../slang/contexts/runtime_context'

class Main
  def run
    first('first.sl')
    # second()
  end

  def first file_name
    return if file_name == nil
    # code = File.read(file_name)
    code = "NUMERIC a; a=20; PRINTLINE a;"
    
    p = RDParser.new(code)
    compilation_context = CompilationContext.new
    statements = p.parse(compilation_context)
    # puts statements

    runtime_context = RuntimeContext.new

    statements.each do |statement|
      puts statement.accept(runtime_context, Interpreter.new)
    end

  end

  def second
  end
end

m = Main.new
m.run