# Flipkart Automation (Robot Framework, POM)

This project contains a simple Robot Framework automation skeleton for Flipkart using a Page Object Model style with resource files.

Prerequisites
- Python 3.8+
- Chrome browser

Quick setup

1. Create and activate a venv:
   python3 -m venv .venv
   source .venv/bin/activate

2. Install dependencies:
   pip install -r requirements.txt

3. Run tests (example):
   robot -d reports tests/search_product.robot

CI / Reports
- GitHub Actions workflow is added at `.github/workflows/robot.yml` — it runs the tests and uploads the `reports/` directory as an artifact.
- Jenkins pipeline is provided in `Jenkinsfile` (archives `reports/` and publishes xUnit results).

Screenshots & failures
- Tests capture a screenshot on failure into `reports/screenshots` using the `Capture Screenshot On Failure` keyword (configured as a Test Teardown).


Notes
- This is a starter skeleton. You may need to download the proper webdriver or let webdriver-manager handle it.
