from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
import os


def get_chrome_driver_path():
    """Return the path to the chromedriver executable managed by webdriver-manager.

    Kept for backwards compatibility; prefer using `get_chrome_service` which
    returns a Selenium Service instance suitable for SeleniumLibrary's
    `service` argument.
    """
    return ChromeDriverManager().install()


def get_chrome_service():
    """Return a selenium.webdriver.chrome.service.Service instance pointing to
    a chromedriver managed by webdriver-manager.
    
    Robot keyword name: Get Chrome Service
    """
    return Service(ChromeDriverManager().install())


def get_chrome_options(headless=None):
    """Return a configured ChromeOptions instance.

    If `headless` is not provided, the function checks the GITHUB_ACTIONS
    environment variable and enables headless mode when running on GitHub
    Actions. Additional flags useful for CI are also added.
    
    Robot keyword name: Get Chrome Options
    """
    options = webdriver.ChromeOptions()
    # Prefer explicit argument if passed; otherwise, enable headless on CI
    if headless is None:
        headless_flag = os.getenv("GITHUB_ACTIONS", "false").lower() in ("true", "1")
    else:
        headless_flag = str(headless).lower() in ("true", "1", "yes")

    if headless_flag:
        # Use the new headless mode where supported
        try:
            options.add_argument("--headless=new")
        except Exception:
            options.add_argument("--headless")
        options.add_argument("--disable-gpu")

    # Flags that help Chrome run in containerized CI environments
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1920,1080")
    return options

