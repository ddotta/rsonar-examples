#!/usr/bin/env Rscript
# ============================================================
# Example 3 — Quality Gate
# Define thresholds and check if the project passes.
# ============================================================

library(rsonar)

cat("=== Example 3: Quality Gate ===\n\n")

res <- sonar_analyse(".")

# ---- Lenient gate (should pass) ----
cat("--- Lenient gate ---\n")
gate_lenient <- quality_gate(res,
  coverage_min     = 30,
  lint_errors_max  = 10,
  style_issues_max = 5,
  rating_min       = "E"
)
print(gate_lenient)

# ---- Strict gate (should fail) ----
cat("\n--- Strict gate ---\n")
gate_strict <- quality_gate(res,
  coverage_min     = 90,
  lint_errors_max  = 0,
  style_issues_max = 0,
  rating_min       = "A"
)
print(gate_strict)

# ---- In CI: fail the pipeline ----
# Uncomment the next line to exit with code 1 on failure:
# quality_gate(res, coverage_min = 90, fail_on_error = TRUE)
