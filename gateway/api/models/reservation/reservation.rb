class Reservation < Sequel::Model
	many_to_one :movie

	def validate
        super
        reservation_value = Reservation[{movie_id: movie_id, position: position, reservation_date: reservation_date}]
        movie = self.movie
		errors.add(:movie_id, "is required") if !movie_id || movie_id.nil?
		errors.add(:movie_id, "not found") if movie_id && !movie
		errors.add(:position, "is required") if !position || position.nil?
		errors.add(:reservation_date, "is required") if !reservation_date || reservation_date.nil?
        errors.add(:reservation_date, "must be in the future") if (reservation_date < Date.today)
        errors.add(:reservation_date, "must be between movie date range") if movie && !(reservation_date.between?(movie.since_at, movie.until_at))
        error.add(:position, ", reservation_date and movie already exists") if ((new? && reservation_value) || (!(new?) && (reservation_value && reservation_value.id != id) ) )
		errors.add(:created_at, "is required") if !created_at || created_at.nil?
        
	end
end