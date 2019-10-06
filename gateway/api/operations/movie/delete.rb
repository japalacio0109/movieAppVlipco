module OperationsMovie
	class Delete < DynamicOperators
		include Dry::Transaction

		step :validate_if_exists
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = %i[id].freeze
        
		def validate_if_exists(movie) 
			contract = Dry::Validation.Contract do
				params do
					required(:id).value(:integer)
				end
			end
			result = contract.call(movie)
			query_result = Movie.find(id: movie[:id])
			if result.success?
				!(query_result.nil?) ? Success(result.to_h) : Failure({http_404_not_found: "Record not found"})
			else
				Failure(result.errors.to_h)
			end
		end

		def clean(movie)
			Success(movie.select { |k, _v| isInclude(k, ALLOW_PARAMS) })
		end

		def persist(movie)
			Movie.where(id: movie[:id]).delete()
		end
		
	end
end