from webdriver_manager.chrome import ChromeDriverManager

def get_chrome_driver_path():
    """Return the path to the chromedriver executable managed by webdriver-manager."""
    return ChromeDriverManager().install()
