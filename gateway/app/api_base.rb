module Base
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::MovieApp::MovieViewset
    mount ::MovieApp::ReservationViewset
    add_swagger_documentation api_version: 'v1'
  end
end