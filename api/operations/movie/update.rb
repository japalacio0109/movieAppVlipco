module OperationsMovie
	class Update < DynamicOperators
		include Dry::Transaction

		step :validate_if_exists
		step :validate
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = Movie.columns.freeze
		DENY_PARAMS  = %i[id].freeze
        
		def validate_if_exists(movie) 
			contract = Dry::Validation.Contract do
				params do
					required(:id).value(:integer)
					required(:movie)
				end
			end
			result = contract.call(movie)
			query_result = Movie.find(id: movie[:id])
			p movie
			if result.success?
				!(query_result.nil?) ? Success(result.to_h) : Failure({http_404_not_found: "Record not found"})
			else
				Failure(result.errors.to_h)
			end
		end

		def validate(movie)
			contract = MovieContract.new
			movie = movie[:movie].merge(id: movie[:id], name: movie[:movie][:name].upcase)
			result = contract.call(movie)
			result.success? ? Success({id: movie[:id], movie: result.to_h}) : Failure(result.errors.to_h)
		end

		def clean(movie)
			Success({id: movie[:id], movie: movie[:movie].select { |k, _v| isInclude(k, ALLOW_PARAMS) }.except(*DENY_PARAMS)})
		end

		def persist(movie)
			result = Movie.find(id: movie[:id])
			result.update(movie[:movie])
			return result
		end
		
	end
end