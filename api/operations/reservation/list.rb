module OperationsReservation
	class List < DynamicOperators

		include Dry::Transaction

		step :validate
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = %i[id movie_id since_at until_at page].freeze

		def validate(reservation)
			contract = Dry::Validation.Contract do
				params do
					optional(:id).value(:integer)
					optional(:movie_id).value(:integer)
					optional(:since_at).value(:date)
					optional(:until_at).value(:date)
					optional(:page).value(:integer)
				end
			end
			result = contract.call(reservation)
			result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
		end

		def clean(reservation)
			Success(reservation.select { |k, _v| isInclude(k, ALLOW_PARAMS) })
		end

		def persist(reservation)
			query = Reservation
			if reservation.empty?
				return getPaginatedDataSet(query.dataset)
			end
			if reservation[:id] 
				return query.find(id: reservation[:id])
			end
			queryset = query.dataset
			
			if reservation[:movie_id]
				queryset = queryset.filter(movie: reservation[:movie_id])
			end

			if reservation[:since_at] and reservation[:until_at]
				queryset = queryset.filter{ reservation_date >= (reservation[:since_at]) & reservation_date <= (reservation[:until_at])} 
			end
			
			return getPaginatedDataSet(queryset,  (movie[:page] || 1).to_i)

		end
		
	end
end