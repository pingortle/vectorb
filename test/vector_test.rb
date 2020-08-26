require "minitest/autorun"

require_relative "../vector"

class TestVector < Minitest::Test
  module Assertions
    def assert_array_equal(expected, subject)
      assert_equal expected.to_a, subject.to_a
    end
  end

  module Helpers
    def rational(*args)
      args.map(&method(:Rational))
    end

    def v(*args)
      Vector.of(*args)
    end
  end

  class TestWithNone < Minitest::Test
    include Assertions
    include Helpers

    def test_magnitude_is_zero
      assert_equal 0, v.magnitude
    end

    def test_normalized_is_empty
      assert_equal 0, v.normalized.count
    end

    def test_scalar_multiplication_works
      assert_array_equal [], v * 2
    end
  end

  class TestWithOne < Minitest::Test
    include Assertions
    include Helpers

    def test_magnitude
      assert_equal 2, v(2).magnitude
    end

    def test_normalized
      assert_array_equal [1], v(2).normalized
    end

    def test_scalar_multiplication
      assert_array_equal [4], v(2) * 2
    end

    def test_addition
      assert_array_equal [5], v(2) + v(3)
    end

    def test_hadamard
      assert_array_equal [6], v(2).hadamard(v(3))
    end

    def test_dot_product
      assert_equal 6, v(2).dot(v(3))
    end

    def test_scalar_projection
      assert_equal 2, v(2).scalar_project_onto(v(3))
    end

    def test_vector_projection
      assert_array_equal [2], v(2).vector_project_onto(v(3))
    end
  end

  class TestWithMany < Minitest::Test
    include Assertions
    include Helpers

    def test_magnitude
      assert_equal 6, v(2, 4, 4).magnitude
    end

    def test_normalized
      assert_array_equal(
        [1, 0, 0],
        v(1337, 0, 0).normalized
      )
      assert_array_equal(
        rational("1/3", "2/3", "2/3"),
        v(2, 4, 4).normalized
      )
    end

    def test_normalized_magnitude
      assert_in_epsilon(1, v(1337, 1337, 0).normalized.magnitude)
    end

    def test_scalar_multiplication
      assert_array_equal(
        [2, 4, 6],
        v(1, 2, 3) * 2
      )
    end

    def test_addition
      assert_array_equal(
        [3, 5, 7],
        v(1, 2, 3) + v(2, 3, 4)
      )
    end

    def test_hadamard
      assert_array_equal(
        [2, 6, 12],
        v(1, 2, 3).hadamard(v(2, 3, 4))
      )
    end

    def test_dot_product
      assert_equal 22, v(2, 4, 4).dot(v(1, 2, 3))
    end

    def test_scalar_projection
      assert_equal 0, v(1, 0, 0).scalar_project_onto(v(0, 1, 0))
      assert_equal 1, v(1, 0, 0).scalar_project_onto(v(1, 0, 0))
      assert_equal 2, v(10, 5, -6).scalar_project_onto(v(3, -4, 0))
    end

    def test_vector_projection
      assert_array_equal(
        [1.2, -1.6, 0],
        v(10, 5, -6).vector_project_onto(v(3, -4, 0))
      )
    end
  end
end
