class MovieContract < DynamicContracts
     params do
        optional(:id).value(:integer)
        optional(:name).value(:string)
        optional(:description).value(:string)
        optional(:image_url).value(:string)
        optional(:since_at).value(:date)
        optional(:until_at).value(:date)
    end


    rule(:description, :id) do
        key.failure('Must have at least 10 characters') if (values[:description] && values[:description].length < 10)
    end

    rule(:image_url, :id) do
        key.failure('Must be a right URL') if values[:image_url] && !(valid_url?(values[:image_url]))
    end

    rule(:since_at, :id) do
        key.failure('Must be in the future') if (values[:since_at] && values[:since_at] < Date.today)
    end

    rule(:until_at, :since_at) do
        key.failure('Must be after since_at date') if ((values[:until_at] && values[:since_at]) && (values[:until_at] < values[:since_at]))
    end
end