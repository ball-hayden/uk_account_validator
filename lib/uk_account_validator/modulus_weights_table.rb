module UkAccountValidator
  class ModulusWeightsTable

    def initialize(path)
      @weights = []

      File.readlines(path).each do |line|
        @weights << ModulusWeight.from_line(line)
      end

      @weights.sort! { |weight| weight.sort_code_start.to_i }
    end

    def find(sort_code, found_weights = [], exclude = [])
      sort_code = sort_code.to_i

      weight = @weights.bsearch do |w|
        w.sort_code_start.to_i <= sort_code && !exclude.include?(w)
      end

      return found_weights if weight.nil?
      return found_weights unless
        weight.sort_code_start.to_i <= sort_code &&
        sort_code <= weight.sort_code_end.to_i

      found_weights << weight

      find(sort_code, found_weights, exclude + [weight])
    end
  end
end
