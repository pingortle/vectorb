require "minitest/autorun"
require "minitest/given"
require "delegate"
require_relative "../vector"

class TestVector
  class TestWithNone
    def setup
      @subject = Vector.new([])
    end

    def test_magnitude_is_zero
      assert_equal @subject.magnitude == 0
    end

    def test_normalized_is_empty
      assert @subject.normalized.empty?
    end

    def test_scalar_multiplication_works
      assert_array_equal @subject * 2, []
    end
  end

  class TestWithOne
    def setup
      @subject = Vector.of(2)
      @other = Vector.of(3)
    end

    def test_magnitude
      assert_equal @subject.magnitude == 2
    end

    def test_normalized
      assert_array_equal @subject.normalized, [1]
    end

    def test_scalar_multiplication
      assert_array_equal @subject * 2, [4]
    end

    def test_addition
      assert_array_equal @subject + @other, [5]
    end

    def test_hadamard
      assert_array_equal @subject * @other, [6]
    end

    def test_dot_product
      assert_equal @subject.dot(@other), 6
    end

    def test_scalar_projection
      assert_equal @subject.scalar_project_onto(@other), 2
    end

    def test_vector_projection
      assert_array_equal @subject.vector_project_onto(@other), [2]
    end
  end
end
