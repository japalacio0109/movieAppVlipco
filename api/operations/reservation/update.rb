module OperationsReservation
	class Update < ReservationOperatorBase
		include Dry::Transaction

		step :validate_if_exists
		step :validate
		step :validate_10_records
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = Reservation.columns.freeze
		DENY_PARAMS  = %i[id].freeze
        
		def validate_if_exists(reservation) 
			contract = Dry::Validation.Contract do
				params do
					required(:id).value(:integer)
					required(:reservation)
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

		def validate(reservation)
			contract = ReservationContract.new
			reservation = reservation.merge(reservation: reservation[:reservation].merge(created_at: Time.now)) 
			result = contract.call(reservation[:reservation])
			result.success? ? Success({id: reservation[:id], reservation: result.to_h}) : Failure(result.errors.to_h)
		end

		def clean(reservation)
			Success({id: reservation[:id], reservation: reservation[:reservation].select { |k, _v| isInclude(k, ALLOW_PARAMS) }.except(*DENY_PARAMS)})
		end

		def persist(reservation)
			result = Reservation.find(id: reservation[:id])
			result.update(reservation[:reservation])
			return result
		end
		
	end
end