require 'dry/validation'
class DynamicContracts < Dry::Validation::Contract
    def valid_url?(url)
        url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
        url =~ url_regexp ? true : false
    end
end