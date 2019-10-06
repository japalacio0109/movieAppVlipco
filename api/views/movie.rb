module MovieApp
  class MovieViewset < DynamicViewset
    
    format :json

    desc 'Get all Movies!' do
      detail 'this will expose all the movies'
    end


    get '/movie' do
      ::OperationsMovie::List.new.call(params) do |m|
        m.success do |response|
          response
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    post '/movie' do
      ::OperationsMovie::Create.new.call(params[:movie]) do |m|
        m.success do |response|
          {response: response.values}
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    patch '/movie/:id' do
      ::OperationsMovie::Update.new.call(params) do |m|
        m.success do |response|
          {response: response}
        end

        m.failure do |response|
          {errors: response, status: :not_acceptable}
        end
      end
    end

    delete '/movie/:id' do
      ::OperationsMovie::Delete.new.call(params) do |m|
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