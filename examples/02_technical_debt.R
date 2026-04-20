#!/usr/bin/env Rscript
# ============================================================
# Example 2 — Technical Debt (SQALE Model)
# Compute technical debt with custom costs.
# ============================================================

library(rsonar)

cat("=== Example 2: Technical Debt ===\n\n")

res <- sonar_analyse(".")

# Default costs
debt_default <- debt_index(res)
print(debt_default)

# Custom costs (stricter on lint errors, relaxed on style)
cat("\n--- Custom cost model ---\n")
debt_strict <- debt_index(res,
  cost_lint_error   = 60,   # 1h per lint error
  cost_lint_warning = 15,
  cost_style        = 2,
  coverage_target   = 90    # stricter coverage target
)
print(debt_strict)

cat("\nDefault rating:", debt_default$rating, "\n")
cat("Strict rating: ", debt_strict$rating, "\n")
