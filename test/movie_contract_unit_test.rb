require 'minitest/autorun'
require 'minitest/pride'
require_relative './test_base'
require_relative '../api/models/movie/movie_contract'

class MovieContractTest < TestBase

  def test_movie_contract_empty
    contract = MovieContract.new
    reservation = get_reservation_fixtures()[:error_by_empty]
    reservation = reservation[:movie]
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:name].include?("Field is required")
    assert result.errors.to_h[:description].include?("Field is required")
    assert result.errors.to_h[:image_url].include?("Field is required")
    assert result.errors.to_h[:since_at].include?("Field is required")
    assert result.errors.to_h[:until_at].include?("Field is required")
  end

  def test_movie_contract_success
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:true_assert_on_check]
    reservation = reservation[:movie].merge(name: reservation[:movie][:name].upcase)
    result = contract.call(reservation)
    assert result.success?
  end

  def test_movie_contract_fail_by_name
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:error_by_name]
    reservation = reservation[:movie]
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:name].include?("Field is required")
  end

  def test_movie_contract_fail_by_short_description
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:short_description]
    reservation = reservation[:movie].merge(name: reservation[:movie][:name].upcase)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:description].include?("Must have at least 10 characters")
  end

  def test_movie_contract_fail_by_url
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:error_by_url]
    reservation = reservation[:movie].merge(name: reservation[:movie][:name].upcase)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:image_url].include?("Must be a right URL")
  end

  def test_movie_contract_fail_because_since_at_before_today
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:error_by_since_at_before_today]
    reservation = reservation[:movie].merge(name: reservation[:movie][:name].upcase)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:since_at].include?("Must be in the future")
  end

  def test_movie_contract_fail_because_until_at_before_since_at
    contract = MovieContract.new
    reservation = get_movie_fixtures()[:error_by_until_at_after_since_at]
    reservation = reservation[:movie].merge(name: reservation[:movie][:name].upcase)
    result = contract.call(reservation)
    assert !result.success?
    assert result.errors.to_h[:until_at].include?("Must be after since_at date")
  end

end