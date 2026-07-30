#!/usr/bin/env Rscript
# ============================================================
# Example 10 — Hotspots (Files to Fix First)
# Rank files by estimated technical debt to prioritize remediation.
# ============================================================

library(rsonar)

cat("=== Example 10: Hotspots ===\n\n")

res <- sonar_analyse(".")

# Top 10 files by estimated technical debt (default)
hotspots <- sonar_hotspots(res)
print(hotspots)

# In this demo package, messy_code.R has lint issues, style violations
# and no test coverage, so it should always come out on top:
cat("\n--- Top offender ---\n")
cat("File: ", hotspots$file[1], "\n")
cat("Debt: ", hotspots$debt_minutes[1], "min\n")

# Only the single worst file
cat("\n--- Top 1 only ---\n")
print(sonar_hotspots(res, n = 1))

# Custom cost model: penalize lint errors much more heavily
cat("\n--- Custom weighting (errors cost 60 min instead of 30) ---\n")
hotspots_strict <- sonar_hotspots(res,
  cost_lint_error   = 60,
  cost_lint_warning = 15,
  cost_style        = 10
)
print(hotspots_strict)

# Combine with the category breakdown from debt_index() for full context:
# debt_index() tells you WHAT kind of debt dominates, sonar_hotspots()
# tells you WHERE it lives.
cat("\n--- Category breakdown, for comparison ---\n")
debt <- debt_index(res)
print(debt$breakdown[order(-debt$breakdown$minutes), ])
