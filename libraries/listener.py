"""
Robot Framework listener to capture screenshots and page source on test failure.
"""
import os
from robot.libraries.BuiltIn import BuiltIn

ROBOT_LISTENER_API_VERSION = 3

class FailureListener:
    """Listens for test failures and captures browser artifacts for debugging."""

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.builtin = BuiltIn()
        self.screenshot_dir = os.path.join(self.get_output_dir(), 'screenshots')
        self.pagesource_dir = os.path.join(self.get_output_dir(), 'page_sources')
        self._ensure_dirs()

    def _ensure_dirs(self):
        """Ensure screenshot and page source directories exist."""
        os.makedirs(self.screenshot_dir, exist_ok=True)
        os.makedirs(self.pagesource_dir, exist_ok=True)

    def get_output_dir(self):
        """Get Robot Framework's output directory."""
        return self.builtin.get_variable_value('${OUTPUT DIR}', '.')

    def end_test(self, test, result):
        """Called at the end of each test; capture artifacts if the test failed."""
        if result.status == 'FAIL':
            test_name = test.name.replace(' ', '_')
            self.capture_artifacts(test_name)

    def capture_artifacts(self, test_name):
        """Capture screenshot and page source."""
        try:
            # Try to get a selenium driver from SeleniumLibrary
            sl = BuiltIn().get_library_instance('SeleniumLibrary')
            driver = sl.get_selenium_library().driver

            if driver:
                # Capture screenshot
                screenshot_path = os.path.join(self.screenshot_dir, f'{test_name}_failure.png')
                driver.save_screenshot(screenshot_path)
                self.builtin.log(f'Screenshot saved: {screenshot_path}')

                # Capture page source
                page_source_path = os.path.join(self.pagesource_dir, f'{test_name}_source.html')
                with open(page_source_path, 'w', encoding='utf-8') as f:
                    f.write(driver.page_source)
                self.builtin.log(f'Page source saved: {page_source_path}')
        except Exception as e:
            self.builtin.log(f'Failed to capture artifacts: {e}', 'WARN')
