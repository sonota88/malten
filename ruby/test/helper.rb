require "minitest/autorun"

PROJECT_DIR = File.expand_path("../../", __dir__)

$LOAD_PATH.unshift PROJECT_DIR

CONFIG = {
  mal_dir: File.join(PROJECT_DIR, "mal")
}

require_relative "../malten"

def test_tco
  begin
    yield
  rescue SystemStackError => e
    e.backtrace[0...10].each { |trace|
      puts "  |" + trace
    }
    puts "..."
    e.backtrace[-30..-1].each { |trace|
      puts "  |" + trace
    }
    flunk(e)
  end
end
