module OperationsReservation
	class Create < ReservationOperatorBase
		include Dry::Transaction

		step :validate
		step :validate_10_records
		step :clean
		try :persist, catch: StandardError

		ALLOW_PARAMS = Reservation.columns.freeze
    	DENY_PARAMS  = %i[id].freeze

		def validate(reservation)
			contract = ReservationContract.new
			reservation = reservation.merge(created_at: Time.now)
			result = contract.call(reservation)
			result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
		end
		
		def clean(reservation)
			Success(reservation.select { |k, _v| isInclude(k, ALLOW_PARAMS) }.except(*DENY_PARAMS))
		end

		def persist(reservation)
			Reservation.create(reservation)
		end
		
	end
end