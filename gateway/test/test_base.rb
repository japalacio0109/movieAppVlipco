require_relative '../lib/common/dynamic_contracts'
require_relative '../lib/common/dynamic_operators'
require 'active_support'
require 'active_support/time'

class TestBase < Minitest::Test
    def get_movie_fixtures()
        return {
            "error_by_empty": {
                "movie": {}
            },
            "true_assert_on_check": {
                "movie": {
                    "name": "prueba",
                    "description": "asdasdasdasdasdasdasda",
                    "image_url": "http://www.google.com",
                    "since_at": Date.today,
                    "until_at": Date.today + 1.days
                }
            },
            "error_by_name": {
                "movie": {
                    "description": "asdasdasdasdasdasdasda",
                    "image_url": "http://www.google.com",
                    "since_at": Date.today,
                    "until_at": Date.today + 1.days
                }
            },
            "short_description": {
                "movie": {
                    "name": "prueba",
                    "description": "asdqwezxc",
                    "image_url": "http://www.google.com",
                    "since_at": Date.today,
                    "until_at": Date.today + 1.days
                }
            },
            "error_by_url": {
                "movie": {
                    "name": "prueba",
                    "description": "asdasdasdasdasdasdasda",
                    "image_url": "asdasdasd",
                    "since_at": Date.today,
                    "until_at": Date.today + 1.days
                }
            },
            "error_by_since_at_before_today": {
                "movie": {
                    "name": "prueba",
                    "description": "asdasdasdasdasdasdasda",
                    "image_url": "http://www.google.com",
                    "since_at": Date.today - 1.days,
                    "until_at": Date.today + 1.days
                }
            },
            "error_by_until_at_after_since_at": {
                "movie": {
                    "name": "prueba",
                    "description": "asdasdasdasdasdasdasda",
                    "image_url": "http://www.google.com",
                    "since_at": Date.today + 1.days,
                    "until_at": Date.today
                }
            }
        }
    end

    def get_reservation_fixtures()
        {
            "error_by_empty": {
                "reservation": {}
            },
            "true_assert_on_check": {
                "reservation": {
                    "movie_id": 1,
                    "position": 10,
                    "reservation_date": Date.today + 1.days
                }
            },
            "error_by_movie_id": {
                "reservation": {
                    "position": 10,
                    "reservation_date": Date.today + 1.days
                }
            },
            "error_by_out_range_position": {
                "reservation": {
                    "movie_id": 2,
                    "position": 34,
                    "reservation_date": Date.today + 1.days,
                }
            },
            "error_by_reservation_date_before_today": {
                "reservation": {
                    "movie_id": 2,
                    "position": 10,
                    "reservation_date": Date.today - 1.days,
                }
            },
            "search_params": {
                "id": 1,
                "movie_id": 1,
            }
        }
    end
end