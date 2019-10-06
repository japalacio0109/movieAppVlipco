module MovieApp
  class ReservationViewset < DynamicViewset
    
    format :json

    desc 'Get all Reservations!' do
      detail 'this will expose all the movies reservations'
    end


    get '/reservation' do
      ::OperationsReservation::List.new.call(params) do |m|
        m.success do |response|
          response
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    post '/reservation' do
      ::OperationsReservation::Create.new.call(params[:reservation]) do |m|
        m.success do |response|
          {response: response.values}
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    patch '/reservation/:id' do
      ::OperationsReservation::Update.new.call(params) do |m|
        m.success do |response|
          {response: response}
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    delete '/reservation/:id' do
      ::OperationsReservation::Delete.new.call(params) do |m|
        m.success do |response|
          {response: response}
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

  end
end