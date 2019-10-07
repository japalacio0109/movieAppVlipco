require 'minitest/autorun'
require 'minitest/pride'
require_relative './test_base'
require_relative '../api/models/reservation/reservation_contract'

class ReservationContractTest < TestBase
  
  def test_reservation_contract_success
    contract = ReservationContract.new
    reservation = get_reservation_fixtures()[:true_assert_on_check]
    reservation = reservation[:reservation].merge(created_at: Time.now)
    result = contract.call(reservation)
    assert result.success?
  end
  
  def test_reservation_contract_fail_by_out_range_position
    contract = ReservationContract.new
    reservation = get_reservation_fixtures()[:error_by_out_range_position]
    reservation = reservation[:reservation].merge(created_at: Time.now)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:position].include?("Value must be between (1,10) range")
  end

  def test_reservation_contract_fail_by_reservation_date_before_today
    contract = ReservationContract.new
    reservation = get_reservation_fixtures()[:error_by_reservation_date_before_today]
    reservation = reservation[:reservation].merge(created_at: Time.now)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:reservation_date].include?("Must be in the future")
  end

end