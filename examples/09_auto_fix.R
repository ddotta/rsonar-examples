#!/usr/bin/env Rscript
# ============================================================
# Example 9 — Auto-Fix with air
# Demonstrate automatic code formatting with air,
# dry-run mode, and MR/PR creation.
# ============================================================

library(rsonar)

cat("=== Example 9: Auto-Fix with air ===\n\n")

# ---- Step 1: Install air (once per machine) ----
cat("--- Step 1: Installing air ---\n\n")
# Uncomment to install air automatically:
# install_air()
cat("To install air, run: rsonar::install_air()\n")
cat("Or manually: https://github.com/posit-dev/air\n\n")

# ---- Step 2: Dry-run — check what would change ----
cat("--- Step 2: Dry-run check ---\n\n")
fix_dry <- tryCatch(
  sonar_fix(".", dry_run = TRUE),
  error = function(e) {
    cat("air not available. Install it first:\n")
    cat("  rsonar::install_air()\n")
    cat("Or download from: https://github.com/posit-dev/air\n")
    NULL
  }
)

if (!is.null(fix_dry)) {
  print(fix_dry)

  if (length(fix_dry$files_changed) > 0) {
    cat("\n--- Files that would be formatted ---\n")
    for (f in fix_dry$files_changed) {
      cat("  -", f, "\n")
    }
  } else {
    cat("\nNo files need formatting. Code is already clean!\n")
  }
}

# ---- Step 3: Apply fixes (uncomment to run) ----
cat("\n--- Step 3: Apply fixes (commented out for safety) ---\n\n")
cat("# Uncomment the lines below to auto-format your code:\n")
cat("# fix <- sonar_fix(\".\", dry_run = FALSE)\n")
cat("# print(fix)\n\n")

# ---- Step 4: Auto-fix + create Merge Request (CI only) ----
cat("--- Step 4: Auto-fix + Merge Request ---\n\n")
cat("# In CI, use create_mr = TRUE to automatically:\n")
cat("#   1. Format all R files with air\n")
cat("#   2. Create a new branch rsonar/auto-fix-{timestamp}\n")
cat("#   3. Commit and push changes\n")
cat("#   4. Open a Merge Request (GitLab) or Pull Request (GitHub)\n\n")
cat("# fix <- sonar_fix(\".\", create_mr = TRUE)\n\n")

# ---- Step 5: Fix specific files only ----
cat("--- Step 5: Fix specific files ---\n\n")
cat("# You can also target specific files:\n")
cat("# fix <- sonar_fix(\".\",\n")
cat("#   files = c(\"R/messy_code.R\", \"R/clean_code.R\"))\n\n")

cat("Done! See documentation for more options.\n")