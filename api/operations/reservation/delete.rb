module OperationsReservation
	class Delete < DynamicOperators
		include Dry::Transaction

		step :validate_if_exists
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = %i[id].freeze
        
		def validate_if_exists(reservation) 
			contract = Dry::Validation.Contract do
				params do
					required(:id).value(:integer)
				end
			end
			result = contract.call(reservation)
			query_result = Reservation.find(id: reservation[:id])
			if result.success?
				!(query_result.nil?) ? Success(result.to_h) : Failure({http_404_not_found: "Record not found"})
			else
				Failure(result.errors.to_h)
			end
		end

		def clean(reservation)
			Success(reservation.select { |k, _v| isInclude(k, ALLOW_PARAMS) })
		end

		def persist(reservation)
			Reservation.where(id: reservation[:id]).delete()
		end
		
	end
end