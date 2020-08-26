class Vector
  include Enumerable

  def self.of(*components)
    new(components)
  end

  def initialize(components)
    @components = components
  end

  def each(&block)
    @components.each(&block)
  end

  def +(other)
    Vector.new(zip(other).map(&:sum))
  end

  def *(other)
    Vector.new(map { |x| x * other })
  end

  def hadamard(other)
    Vector.new(zip(other).map { |a, b| a * b })
  end

  def dot(other)
    hadamard(other).sum
  end

  def vector_project_onto(other)
    other.normalized * scalar_project_onto(other)
  end

  def scalar_project_onto(other)
    dot(other.normalized)
  end

  def normalized
    @normalized ||= Vector.new(
      map { |x| x / magnitude }
    )
  end

  def magnitude
    @magnitude ||= Math.sqrt(dot(self))
  end
end
