module UkAccountValidator
  class ModulusWeight
    attr_reader :sort_code_start, :sort_code_end, :modulus, :u, :v, :w, :x,
                :y, :z, :a, :b, :c, :d, :e, :f, :g, :h, :exception

    # @param definition_line The line from valacdos.txt that defines this weight.
    def self.from_line(definition_line)
      data = definition_line.split(' ')
      data[17] ||= ''

      ModulusWeight.new(*data)
    end

    def initialize(sort_code_start, sort_code_end, modulus, u, v, w, x, y, z,
          a, b, c, d, e, f, g, h, exception)

      @sort_code_start = sort_code_start
      @sort_code_end   = sort_code_end
      @modulus         = modulus
      @exception       = exception

      @u, @v, @w, @x, @y, @z, @a, @b, @c, @d, @e, @f, @g, @h =
        [u.to_i, v.to_i, w.to_i, x.to_i, y.to_i, z.to_i, a.to_i, b.to_i, c.to_i,
         d.to_i, e.to_i, f.to_i, g.to_i, h.to_i]
    end
  end
end
