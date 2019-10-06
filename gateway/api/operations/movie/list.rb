module OperationsMovie
	class List < DynamicOperators

		include Dry::Transaction

		step :validate
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = Movie.columns.freeze
    	DENY_PARAMS  = %i[description image_url].freeze

		def validate(movie)
			contract = Dry::Validation.Contract do
				params do
					optional(:id).value(:integer)
					optional(:name).value(:string)
					optional(:since_at).value(:date)
					optional(:until_at).value(:date)
					optional(:page).value(:integer)
				end
			end
			result = contract.call(movie)
			result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
		end

		def clean(movie)
			Success(movie.select { |k, _v| isInclude(k, ALLOW_PARAMS) })
		end

		def persist(movie)
			query = Movie
			if movie.empty?
				return getPaginatedDataSet(query.dataset)
			end
			if movie[:id] 
				return query.find(id: movie[:id])
			end
			queryset = query.dataset
			if movie[:name]
				queryset = queryset.grep(:name, "%#{movie[:name]}%")
			end
			if movie[:since_at] 
				queryset = queryset.filter{ until_at >= (movie[:since_at])}
			end
			if movie[:until_at] 
				queryset = queryset.filter{since_at <= (movie[:until_at])}
			end
			return getPaginatedDataSet(queryset,  (movie[:page] || 1).to_i)
		end
		
	end
end