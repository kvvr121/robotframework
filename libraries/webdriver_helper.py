from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

def create_chrome_driver(headless=False):
    """Create and return a Chrome webdriver instance.

    The Robot Framework keyword name will be 'Create Chrome Driver' because
    Robot replaces underscores with spaces when mapping function names to
    keywords.
    """
    options = webdriver.ChromeOptions()
    if str(headless).lower() in ('true', '1', 'yes'):
        options.add_argument('--headless=new')
        options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--window-size=1920,1080')
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=options)
    return driver
