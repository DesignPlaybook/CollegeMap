class AhpCalculator
    attr_reader :criteria, :comparisons, :normalized_matrix, :priority_vector, :consistency_matrix, :weighted_sum_vector
    RI_VALUES = { 1 => 0, 2 => 0, 3 => 0.58, 4 => 0.90, 5 => 1.12, 6 => 1.24 } # RI values for up to 6 criteria
  
    def initialize(criteria, comparisons)
      @criteria = criteria
      @comparisons = comparisons
    end
  
    # Step 3: Normalize the Matrix
    def normalize_matrix
      column_sums = Array.new(@criteria.length, 0)
  
      @comparisons.each do |row|
        row.each_with_index { |val, i| column_sums[i] += val }
      end
  
      @normalized_matrix = @comparisons.map do |row|
        row.map.with_index { |val, i| val.to_f / column_sums[i] }
      end
    end
  
    # Step 4: Compute Priority Vector or criteria weights
    def calculate_priority_vector
      normalize_matrix
      @priority_vector = @normalized_matrix.map do |row|
        row.sum / row.length  # Average of each row
      end
    end
  
    # Step 6: Compute Consistency Matrix
    def calculate_consistency_matrix
      @consistency_matrix = @comparisons.map do |row|
        row.each_with_index.map { |val, i| val * @priority_vector[i] }
      end
  
      # Weighted sum vector
      @weighted_sum_vector = @consistency_matrix.map(&:sum)
    end
  
    # Step 7: Compute Lambda Max, CI, and CR
    def calculate_consistency_ratio
      calculate_priority_vector
      calculate_consistency_matrix
  
      lambda_max = @weighted_sum_vector.each_with_index.map { |ws, i| ws / @priority_vector[i] }.sum / @criteria.length
      ci = (lambda_max - @criteria.length) / (@criteria.length - 1)
      ri = RI_VALUES[@criteria.length] || 1.24 # Default RI if not found
      cr = ci / ri
      consistency_score = 100/(2.718 ** (cr *2)) 
  
      { lambda_max: lambda_max.round(4), ci: ci.round(4), cr: cr.round(4), consistency_score: consistency_score.round(2) }
    end
  
    # Final Result (Weights + Consistency Check)
    def result
      consistency = calculate_consistency_ratio
      weights = @criteria.zip(@priority_vector).to_h
  
      { weights: weights, consistency: consistency }
    end
end