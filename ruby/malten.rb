require_relative "mal"

class FakeStdout
  def initialize
    @s = ""
  end

  def write(x)
    @s += x.to_s
  end

  def to_s
    @s
  end
end

class Malten
  def self.render(context, template)
    renderer =
      Mal.eval(
        { template: template },
        "(gen-renderer template)"
      )

    orig_stdout = $stdout
    $stdout = FakeStdout.new

    Mal.eval(context, renderer)
    out = $stdout.to_s

    $stdout = orig_stdout

    out
  end
end
