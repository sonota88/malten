PROJECT_DIR = File.expand_path("../", __dir__)

CONFIG = {
  mal_dir: File.join(PROJECT_DIR, "mal")
}

require_relative "malten"

template = File.read(File.join(PROJECT_DIR, "template.html"))

context = {
  date: "2021-12-25",
  items: [
    { id: 1, name: "foo", price: 100, discount: nil },
    { id: 2, name: "bar", price: 200, discount: nil },
    { id: 3, name: "baz", price: 300, discount: 50 }
  ]
}

rendered = Malten.render(context, template)

puts rendered
