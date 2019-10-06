module OperationsMovie
	class Create < DynamicOperators
		include Dry::Transaction

		step :validate
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = Movie.columns.freeze
    	DENY_PARAMS  = %i[id].freeze

		def validate(movie)
			p ALLOW_PARAMS
			contract = MovieContract.new
			movie = movie.merge(name: movie[:name].upcase)
			result = contract.call(movie)
			result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
		end

		def clean(movie)
			Success(movie.select { |k, _v| isInclude(k, ALLOW_PARAMS) }.except(*DENY_PARAMS))
		end

		def persist(movie)
			Movie.create(movie)
		end
		
	end
end