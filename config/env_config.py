import os
from datetime import datetime, timedelta

class EnvConfig:
    """
    Template for environment configuration.
    """
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    # Application Config
    BASE_URL = "https://morent-car.archisacademy.com/"
    BROWSER = "chrome"
    SHORT_TIMEOUT = 5
    MEDIUM_TIMEOUT = 15
    LONG_TIMEOUT = 20
    RETRY_COUNT = "3x"

    # Test Data
    PAGE_NOT_FOUND_CODE = "404"
    SERVER_ERROR_CODE = "500"
    
    # Test Account Credentials (use env vars in CI; never commit real secrets)
    TEST_EMAIL = os.environ.get("MORENT_TEST_EMAIL", "doe+clerk_test@example.com")
    TEST_PASSWORD = os.environ.get("MORENT_TEST_PASSWORD", "morenttest@12345")
    TEST_OTP = os.environ.get("MORENT_TEST_OTP", "424242")
    
    # Screenshot Configuration
    SCREENSHOT_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "results", "screenshots")
    
    # Default Test Data
    DEFAULT_PICKUP_LOCATION = "New York"
    DEFAULT_DROPOFF_LOCATION = "New York"
    # Booking flow (SG-27) – Billing
    BILLING_NAME = "Test User"
    BILLING_PHONE = "+1234567890"
    BILLING_ADDRESS = "123 Test Street"
    BILLING_CITY = "New York"
    # Rental dates/times (dynamic: today + 3 and + 7 days so tests stay valid)
    _today = datetime.now().date()
    RENTAL_PICKUP_DATE = (_today + timedelta(days=3)).strftime("%Y-%m-%d")
    RENTAL_DROPOFF_DATE = (_today + timedelta(days=7)).strftime("%Y-%m-%d")
    RENTAL_PICKUP_TIME = "10:00"
    RENTAL_DROPOFF_TIME = "10:00"
    
    def get_config_value(self, key):
        """Get configuration value by key."""
        return getattr(self, key)
