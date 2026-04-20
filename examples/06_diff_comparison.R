#!/usr/bin/env Rscript
# ============================================================
# Example 6 — Comparing Analyses (Diff)
# Compare a baseline vs. current state to detect regressions.
# ============================================================

library(rsonar)

cat("=== Example 6: Analysis Diff ===\n\n")

# Simulate a "baseline" analysis (lint only, fast)
cat("Running baseline analysis...\n")
baseline <- sonar_analyse(".",
  include_coverage     = FALSE,
  include_goodpractice = FALSE
)

cat("Running current analysis...\n")
current <- sonar_analyse(".",
  include_coverage     = FALSE,
  include_goodpractice = FALSE
)

# Compare the two
diff <- sonar_diff(current, baseline)
print(diff)

cat("\nImproved:", diff$improved, "\n")
cat("New issues:", length(diff$new_issues), "\n")
cat("Fixed issues:", length(diff$fixed_issues), "\n")
