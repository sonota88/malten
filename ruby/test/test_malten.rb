require_relative "./helper"

class MaltenTest < Minitest::Test
#   def test_mal_code_len_010
#     len = Mal.eval_v2({}, <<~MAL)
# ()
#     MAL
#     assert_equal(3, len)
#   end

  # def test_010
  #   template = <<~TEMPLATE
  #   a<% mal_code %>b
  #   TEMPLATE

  #   exp = <<~EXPECTED
  #   (do
  #   (print "a")
  #    mal_code 
  #   (print "b")

  #   )
  #   EXPECTED

  #   assert_equal(
  #     exp,
  #     to_mal_templ(template.strip)
  #   )
  # end

  # def test_020
  #   template = <<~TEMPLATE
  #   a<%= (+ 1 2) %>b
  #   TEMPLATE

  #   exp = <<~EXPECTED
  #   (do
  #   (print "a")
  #   (print  (+ 1 2) )
  #   (print "b")

  #   )
  #   EXPECTED

  #   assert_equal(
  #     exp,
  #     to_mal_templ(template.strip)
  #   )
  # end

  def test_1020
    template = <<~TEMPLATE
    a<%= x %>b
    TEMPLATE
    context = { x: 123 }

    rendered = Malten.render(context, template)

    exp = <<~TEXT
    a123b
    TEXT

    assert_equal(exp, rendered)
  end

  def test_1030
    users = [
      { "id" => 1, "name" => "foo" },
      { "id" => 2, "name" => "bar" }
    ]

    template = <<~TEMPLATE
    <% (map (fn* [user] (do %>
    <%= (get user "id") %>: <%= (get user "name") %>
    <% )) users) %>
    TEMPLATE
    context = { users: users }

    rendered = Malten.render(context, template)
    # p rendered

    exp = <<~TEXT

    1: foo

    2: bar

    TEXT

    assert_equal(exp, rendered)
  end

  def test_1040
    users = [
      { "id" => 1, "name" => "foo" },
      { "id" => 2, "name" => "bar" }
    ]

    template = <<~TEMPLATE
    <%
      (def! foop
            (fn* [name]
              (= name "foo")))
    %>
    <% (map (fn* [user] (do %>
    <%= (get user "id") %>: <%= (get user "name") %> <%
      (if (foop (get user "name"))
        (print "[foo]")
        (print "[not foo]")
      )
    %>
    <% )) users) %>
    TEMPLATE
    context = { users: users }

    rendered = Malten.render(context, template)
    # p rendered

    exp = <<~TEXT


    1: foo [foo]

    2: bar [not foo]

    TEXT

    assert_equal(exp, rendered)
  end
end
