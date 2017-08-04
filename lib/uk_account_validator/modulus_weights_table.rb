module UkAccountValidator
  class ModulusWeightsTable

    def initialize(path)
      @weights = []

      File.readlines(path).each do |line|
        @weights << ModulusWeight.from_line(line)
      end

      @weights.sort_by! { |weight| -weight.sort_code_start.to_i }
    end

    def find(sort_code)
      sort_code = sort_code.to_i

      min_found_weight_index = @weights.bsearch_index do |w|
        w.sort_code_start.to_i <= sort_code
      end

      return [] if min_found_weight_index.nil?

      found_weights = []
      index = min_found_weight_index
      while index < @weights.size &&
              @weights[index].sort_code_start.to_i <= sort_code &&
              sort_code <= @weights[index].sort_code_end.to_i
        found_weights << @weights[index]
        index += 1
      end

      found_weights
    end
  end
end
