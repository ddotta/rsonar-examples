#!/usr/bin/env Rscript
# ============================================================
# Example 5 — Selective Analysis
# Run only specific checks (lint, style, coverage, or gp).
# ============================================================

library(rsonar)

cat("=== Example 5: Selective Analysis ===\n\n")

# ---- Lint only (fast) ----
cat("--- Lint only ---\n")
res_lint <- sonar_analyse(".",
  include_style          = FALSE,
  include_coverage       = FALSE,
  include_goodpractice   = FALSE
)
cat("Lint issues:", res_lint$metrics$n_lint_issues, "\n\n")

# ---- Style only ----
cat("--- Style only ---\n")
res_style <- sonar_analyse(".",
  include_lint           = FALSE,
  include_coverage       = FALSE,
  include_goodpractice   = FALSE
)
cat("Style issues:", res_style$metrics$n_style_issues, "\n\n")

# ---- Coverage only ----
cat("--- Coverage only ---\n")
res_cov <- sonar_analyse(".",
  include_lint           = FALSE,
  include_style          = FALSE,
  include_goodpractice   = FALSE
)
cat("Coverage:", res_cov$metrics$coverage_pct, "%\n\n")

# ---- Full analysis ----
cat("--- Full analysis ---\n")
res_full <- sonar_analyse(".")
print(res_full)
