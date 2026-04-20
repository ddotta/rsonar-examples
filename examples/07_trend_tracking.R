#!/usr/bin/env Rscript
# ============================================================
# Example 7 — Trend Tracking
# Persist metrics over time for trend analysis.
# ============================================================

library(rsonar)

cat("=== Example 7: Trend Tracking ===\n\n")

res <- sonar_analyse(".",
  include_coverage     = FALSE,
  include_goodpractice = FALSE
)

# Append to a history file
history_file <- "output/rsonar-history.json"
dir.create("output", showWarnings = FALSE)
sonar_trend(res, file = history_file)

cat("Metrics appended to:", history_file, "\n")

# Read and display the history
history <- jsonlite::read_json(history_file, simplifyVector = TRUE)
cat("\nHistory entries:", nrow(history), "\n")
print(history[, c("timestamp", "n_lint_issues", "n_style_issues", "debt_rating")])
