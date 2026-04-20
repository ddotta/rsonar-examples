#!/usr/bin/env Rscript
# ============================================================
# Example 1 — Basic Analysis
# Run a full rsonar analysis and print the results.
# ============================================================

library(rsonar)

cat("=== Example 1: Basic Analysis ===\n\n")

# Run the full analysis
res <- sonar_analyse(".", verbose = TRUE)

# Print the summary
print(res)

# Show individual metrics
cat("\n--- Raw metrics ---\n")
str(res$metrics)
