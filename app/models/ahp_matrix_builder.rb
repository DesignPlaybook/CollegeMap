# The AhpMatrixBuilder class is responsible for constructing an Analytic Hierarchy Process (AHP) matrix
# from a given JSON input. The AHP matrix is used for pairwise comparisons of criteria in decision-making
# processes.

class AhpMatrixBuilder
    # Builds an AHP matrix from the provided input JSON.
    #
    # @param input_json [Hash] A hash containing a key "_json", which is an array of comparison entries.
    #   Each entry in the array should have:
    #     - "comparisonKey" [String]: A string in the format "criteria1_criteria2".
    #     - "comparisonValue" [Float]: The value of the comparison between the two criteria.
    #
    # @return [Hash] A hash containing:
    #   - :criteria [Array<String>]: An array of unique criteria extracted from the input.
    #   - :matrix [Array<Array<Float>>]: A 2D array (NxN matrix) representing the pairwise comparisons
    #     of the criteria. The diagonal elements are 1.0, and the off-diagonal elements are populated
    #     based on the input comparisons.
    def self.build_ahp_matrix(input_json)
        comparisons = input_json["_json"]

        # Step 1: Extract unique criteria and map them to indices
        criteria = comparisons.flat_map { |entry| entry["comparisonKey"].split("_") }.uniq
        criteria_index = criteria.each_with_index.to_h

        # Step 2: Initialize an NxN matrix with diagonal elements set to 1.0
        n = criteria.size
        matrix = Array.new(n) { Array.new(n, 1.0) }

        # Step 3: Populate the matrix with comparison values
        comparisons.each do |entry|
            crit1, crit2 = entry["comparisonKey"].split("_")
            value = entry["comparisonValue"]

            i, j = criteria_index[crit1], criteria_index[crit2]
            matrix[i][j] = value
            matrix[j][i] = value.zero? ? 0.0 : 1.0 / value
        end

        { criteria: criteria, matrix: matrix }
    end
end
