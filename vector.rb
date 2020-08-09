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
    Vector.new(zip(other).map { |a, b| a * b })
  end

  def dot(other)
    (self * other).sum
  end

  def vector_project_onto(other)
    scalar_projection = scalar_project_onto(other)
    Vector.new(other.normalized.map { |x| scalar_projection * x })
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
