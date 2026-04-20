#!/usr/bin/env Rscript
# ============================================================
# Example 8 — Project Setup Helpers
# Initialize rsonar configuration in a project.
# ============================================================

library(rsonar)

cat("=== Example 8: Project Setup ===\n\n")

# Copy the reference .lintr config
use_rsonar_lintr(".", overwrite = TRUE)
cat("Copied .lintr configuration.\n")

# Copy CI templates
use_rsonar_ci("github", path = ".", overwrite = TRUE)
cat("Copied GitHub Actions workflow template.\n")

use_rsonar_ci("gitlab", path = ".", overwrite = TRUE)
cat("Copied GitLab CI pipeline template.\n")

cat("\nSetup files installed. Review and adapt them to your project.\n")
