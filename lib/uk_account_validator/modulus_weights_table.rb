module UkAccountValidator
  class ModulusWeightsTable

    def initialize(path)
      @weights = []

      File.readlines(path).each do |line|
        @weights << ModulusWeight.new(line)
      end

      @weights.sort! { |weight| weight.sort_code_start.to_i }
    end

    def find(sort_code)
      sort_code = sort_code.to_i

      weight = @weights.bsearch { |w| w.sort_code_start.to_i <= sort_code }

      fail SortCodeNotFound if weight.nil?
      fail SortCodeNotFound unless
        weight.sort_code_start.to_i <= sort_code &&
        sort_code <= weight.sort_code_end.to_i

      weight
    end

    class SortCodeNotFound < StandardError; end
  end
end
