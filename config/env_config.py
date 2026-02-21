import os

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
    
    # Test Account Credentials
    TEST_EMAIL = "doe+clerk_test@example.com"
    TEST_PASSWORD = "morenttest@12345"
    TEST_OTP = "424242"
    
    # Screenshot Configuration
    SCREENSHOT_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "results", "screenshots")
    
    # Default Test Data
    DEFAULT_PICKUP_LOCATION = "New York"
    DEFAULT_DROPOFF_LOCATION = "New York"
    
    def get_config_value(self, key):
        """Get configuration value by key."""
        return getattr(self, key)
