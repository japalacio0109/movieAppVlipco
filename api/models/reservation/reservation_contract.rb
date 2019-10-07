require 'dry/validation'
class ReservationContract < Dry::Validation::Contract
     params do
        optional(:id).value(:integer)
        optional(:movie_id).value(:integer)
        optional(:position).value(:integer)
        optional(:reservation_date).value(:date)
        optional(:created_at)
    end

    rule(:position, :id) do
        key.failure('Value must be between (1,10) range') if !(1..10).include?(values[:position])
    end

    rule(:reservation_date, :id) do
        key.failure('Must be in the future') if values[:reservation_date] && values[:reservation_date] <= Date.today
    end

    rule(:created_at, :id) do
        key.failure('Field is required') if (!values[:created_at])
    end
end