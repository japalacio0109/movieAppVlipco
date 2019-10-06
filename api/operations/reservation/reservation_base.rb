class ReservationOperatorBase < DynamicOperators
    def validate_10_records(reservation)
        base_ = base_premier(reservation)
        conditional = (
        	(base_.count < 10) ||
        	(!(reservation[:id].nil?) && base_.count == 10 && base_.where(id: reservation[:id]).count > 0)
            )
        conditional ? Success(reservation) : Failure({movie_id_reservation_date:["Only 10 reservations per movie"]})
    end

    private 

    def base_premier(reservation)
        Reservation.where(movie_id: reservation[:movie_id], reservation_date: reservation[:reservation_date])
    end
end