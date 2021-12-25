require_relative "./helper"

class MaltenTest < Minitest::Test
  def test_or_010
    act = Mal.eval({}, "(or true true)")
    assert_equal(true, act)
  end

  def test_or_020
    act = Mal.eval({}, "(or true false)")
    assert_equal(true, act)
  end

  def test_or_030
    act = Mal.eval({}, "(or false false)")
    assert_equal(false, act)
  end

  # --------------------------------

  def test_l_sublist_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (l#sublist '(1 2 3 4) 1 3)
        MAL
      )
    assert_equal([2, 3], act)
  end

  # --------------------------------

  # def test_l_join_010
  #   act =
  #     Mal.eval(
  #       {},
  #       <<~MAL
  #         (l#join '(1 2 "a" "b"))
  #       MAL
  #     )
  #   assert_equal("12ab", act)
  # end

  # --------------------------------

  def test_s_to_chars_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#to-chars "fdsa")
        MAL
      )
    assert_equal(%w(f d s a), act)
  end

  # --------------------------------

  def test_s_from_chars_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s.from-chars '("f" "d" "s" "a"))
        MAL
      )
    assert_equal("fdsa", act)
  end

  # --------------------------------

  # def test_s_reverse_010
  #   act =
  #     Mal.eval(
  #       {},
  #       <<~MAL
  #         (s#reverse "fdsa")
  #       MAL
  #     )
  #   assert_equal("asdf", act)
  # end

  # --------------------------------

  def test_l_take_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (l#take '(1 2 3 4) 3)
        MAL
      )
    assert_equal([1, 2, 3], act)
  end

  # --------------------------------

  # def test_s_take_010
  #   act =
  #     Mal.eval(
  #       {},
  #       <<~MAL
  #         (s#take "fdsa" 3)
  #       MAL
  #     )
  #   assert_equal("fds", act)
  # end

  # def test_s_take_020
  #   act =
  #     Mal.eval(
  #       {},
  #       <<~MAL
  #         (s#take "fdsa" 0)
  #       MAL
  #     )
  #   assert_equal(nil, act)
  # end

  # def test_s_take_030
  #   act =
  #     Mal.eval(
  #       {},
  #       <<~MAL
  #         (s#take "fdsa" 4)
  #       MAL
  #     )
  #   assert_equal("fdsa", act)
  # end

  # --------------------------------

  def test_l_drop_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (l#drop '(1 2 3 4) 1)
        MAL
      )
    assert_equal([2, 3, 4], act)
  end

  # --------------------------------

  def test_s_drop_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#drop "fdsa" 1)
        MAL
      )
    assert_equal("dsa", act)
  end

  def test_s_drop_020
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#drop "fdsa" 0)
        MAL
      )
    assert_equal("fdsa", act)
  end

  def test_s_drop_030
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#drop "fdsa" 4)
        MAL
      )
    assert_equal(nil, act)
  end

  # --------------------------------

  def test_s_substring_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#substring "fdsa" 1 3)
        MAL
      )
    assert_equal("ds", act)
  end

  def test_s_substring_020
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#substring "fdsa" 0 0)
        MAL
      )
    assert_equal(nil, act)
  end

  def test_s_substring_030
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#substring "fdsa" 4 4)
        MAL
      )
    assert_equal(nil, act)
  end

  # def test_s_lines_tco
  #   text = "test\n" * 1000

  #   test_tco do
  #     Mal.eval(
  #       { text: text },
  #       <<~MAL
  #       (s#lines text)
  #       MAL
  #     )
  #   end
  # end

  # --------------------------------

  def test_l_size_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (l#size '(1 2 3))
        MAL
      )
    assert_equal(3, act)
  end

  # --------------------------------

  def test_s_to_chars_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#to-chars "")
        MAL
      )
    assert_equal([], act)
  end

  def test_s_to_chars_020
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#to-chars "fdsa")
        MAL
      )
    assert_equal(%w(f d s a), act)
  end

  # --------------------------------

  def test_s_start_with_010
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#start-with? "fdsa" "fd")
        MAL
      )
    assert_equal(true, act)
  end

  def test_s_start_with_020
    act =
      Mal.eval(
        {},
        <<~MAL
          (s#start-with? "fdsa" "_fd")
        MAL
      )
    assert_equal(false, act)
  end

end
