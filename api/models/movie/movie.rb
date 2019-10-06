class Movie < Sequel::Model
	one_to_many :reservations

	def validate
		super
		found_name = Movie[{name: name.upcase}]
		errors.add(:name, "is required") if !name || name.empty?
		errors.add(:name, message: 'is already in use') if ((new? && found_name) || (!(new?) && (found_name && found_name.id != id) ) )
		errors.add(:description, "must have at least 10 characters") if description.empty?
		errors.add(:image_url, "must be a right URL") if image_url.empty?
		errors.add(:since_at, "is required") if since_at.to_s.empty?
		errors.add(:until_at, "is required") if until_at.to_s.empty?
		errors.add(:until_at, "must be in the future") if (until_at < Date.today)
		errors.add(:until_at, message: "must be after since_at date") if (until_at < since_at)
	end
end