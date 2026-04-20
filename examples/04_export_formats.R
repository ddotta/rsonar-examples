#!/usr/bin/env Rscript
# ============================================================
# Example 4 — Export Formats
# Generate reports for different tools and platforms.
# ============================================================

library(rsonar)

cat("=== Example 4: Export Formats ===\n\n")

res <- sonar_analyse(".")

# Create output directory
dir.create("output", showWarnings = FALSE)

# 1. HTML dashboard
sonar_report(res, output = "output/quality-report.html", open = FALSE)
cat("HTML report:  output/quality-report.html\n")

# 2. SonarQube Generic Issue Import JSON
export_sonar_json(res, output = "output/sonar-issues.json")
cat("SonarQube JSON: output/sonar-issues.json\n")

# 3. JUnit XML (GitLab / GitHub Actions / Jenkins)
export_junit(res, output = "output/junit-lint.xml")
cat("JUnit XML:    output/junit-lint.xml\n")

# 4. SARIF (GitHub Code Scanning / VS Code / Azure DevOps)
export_sarif(res, output = "output/rsonar-lint.sarif")
cat("SARIF:        output/rsonar-lint.sarif\n")

cat("\nAll exports generated in output/\n")
