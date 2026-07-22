# rsonar-examples

> Practical examples showcasing [rsonar](https://github.com/ddotta/rsonar) — the SonarQube equivalent for R. Includes automatic code formatting with [air](https://github.com/posit-dev/air).

This repository is a **demo R package** with intentionally clean and messy code, paired with **9 example scripts** and **6 GitHub Actions workflows** to illustrate every feature of the `rsonar` package.

## Repository structure

```
rsonar-examples/
├── R/                          # Demo R package source code
│   ├── clean_code.R            # Well-written functions (greet, fibonacci, bmi)
│   └── messy_code.R            # Intentionally messy code (lint issues, style violations)
├── tests/testthat/             # Unit tests (intentional coverage gaps)
├── examples/                   # Standalone R scripts
│   ├── 01_basic_analysis.R     # Run a full analysis and print results
│   ├── 02_technical_debt.R     # SQALE debt with default and custom costs
│   ├── 03_quality_gate.R       # Quality gate: lenient vs. strict thresholds
│   ├── 04_export_formats.R     # Generate HTML, JSON, JUnit, and SARIF exports
│   ├── 05_selective_analysis.R # Run only lint, style, or coverage individually
│   ├── 06_diff_comparison.R    # Compare two analyses to detect regressions
│   ├── 07_trend_tracking.R     # Persist metrics over time to a JSON history
│   ├── 08_project_setup.R      # Use setup helpers (lintr config, CI templates)
│   └── 09_auto_fix.R           # Auto-format code with air + MR/PR creation
├── .github/workflows/          # GitHub Actions CI examples
│   ├── 01-basic.yml            # Basic analysis + HTML report
│   ├── 02-quality-gate.yml     # Quality gate that blocks the pipeline
│   ├── 03-sarif.yml            # SARIF export → GitHub Code Scanning
│   ├── 04-all-exports.yml      # All export formats in a single job
│   ├── 05-trend.yml            # Trend tracking with auto-commit
│   └── 06-full-pipeline.yml    # Full production pipeline (5 parallel stages)
└── ci-templates/
    └── gitlab-ci.yml           # GitLab CI equivalent pipeline with auto-fix
```

## What is rsonar?

`rsonar` brings SonarQube-style code quality analysis to R projects. It combines:

| Tool | Purpose |
|------|---------|
| [lintr](https://lintr.r-lib.org/) | Static analysis (lint errors, warnings, style) |
| [styler](https://styler.r-lib.org/) | Code formatting checks |
| [covr](https://covr.r-lib.org/) | Test coverage measurement |
| [goodpractice](https://mangothecat.github.io/goodpractice/) | R package best practices |
| [air](https://github.com/posit-dev/air) | Automatic code formatting (auto-fix) |

All results are unified into a single analysis object with technical debt estimation (SQALE model), quality gates, and multiple export formats.

## Quick start

```r
# Install rsonar
remotes::install_github("ddotta/rsonar")

# Clone this repo and run an example
library(rsonar)
res <- sonar_analyse("path/to/rsonar-examples")
print(res)
```

## Example scripts

### 1. Basic analysis (`01_basic_analysis.R`)

Run a full analysis and display the results in the console.

```r
res <- sonar_analyse(".", verbose = TRUE)
print(res)
```

### 2. Technical debt (`02_technical_debt.R`)

Compute SQALE technical debt with default and custom cost models.

```r
debt_default <- debt_index(res)
debt_strict  <- debt_index(res, cost_lint_error = 60, coverage_target = 90)
```

### 3. Quality gate (`03_quality_gate.R`)

Define thresholds and check if the project passes. In CI, use `fail_on_error = TRUE` to exit with code 1.

```r
quality_gate(res, coverage_min = 80, lint_errors_max = 0, fail_on_error = TRUE)
```

### 4. Export formats (`04_export_formats.R`)

Generate reports for every platform:

| Function | Format | Target |
|----------|--------|--------|
| `sonar_report()` | HTML | Browser / artifact |
| `export_sonar_json()` | JSON | SonarQube import |
| `export_junit()` | JUnit XML | GitLab CI / GitHub Actions / Jenkins |
| `export_sarif()` | SARIF 2.1.0 | GitHub Code Scanning / VS Code / Azure DevOps |

### 5. Selective analysis (`05_selective_analysis.R`)

Run only specific checks for faster feedback:

```r
res_lint <- sonar_analyse(".", include_coverage = FALSE, include_goodpractice = FALSE)
```

### 6. Diff comparison (`06_diff_comparison.R`)

Compare a baseline vs. current state:

```r
diff <- sonar_diff(current, baseline)
print(diff)  # Shows IMPROVED or REGRESSED with metric deltas
```

### 7. Trend tracking (`07_trend_tracking.R`)

Persist metrics to a JSON history file:

```r
sonar_trend(res, file = "rsonar-history.json")
```

### 8. Project setup (`08_project_setup.R`)

Initialize rsonar in a new project:

```r
use_rsonar_lintr(".")       # Copy reference .lintr config
use_rsonar_ci("github")     # Copy GitHub Actions workflow
use_rsonar_ci("gitlab")     # Copy GitLab CI pipeline
```

### 9. Auto-fix with air (`09_auto_fix.R`)

Automatically format R code using Posit's `air` formatter:

```r
library(rsonar)

# Install air (once per machine)
install_air()

# Check what would be changed (dry-run)
fix_dry <- sonar_fix(".", dry_run = TRUE)
print(fix_dry)

# Apply formatting to all R files
fix <- sonar_fix(".")

# In CI: create a Merge Request with the fixes
fix <- sonar_fix(".", create_mr = TRUE)
```

In CI pipelines (`rsonar-fix` job):
- Installs `air` via `install_air()`
- Formats all R files automatically
- Optionally creates a Merge Request (GitLab) or Pull Request (GitHub)

## CI workflow examples

### GitHub Actions

| Workflow | Description | Key features |
|----------|-------------|--------------|
| `01-basic.yml` | Basic analysis | HTML report as artifact |
| `02-quality-gate.yml` | Quality gate | JUnit report + pipeline blocking |
| `03-sarif.yml` | SARIF upload | Issues in GitHub Security tab |
| `04-all-exports.yml` | All exports | HTML + JSON + JUnit + SARIF |
| `05-trend.yml` | Trend tracking | Auto-commit history file |
| `06-full-pipeline.yml` | Full pipeline | 5 parallel stages (recommended) |

### GitLab CI

The `ci-templates/gitlab-ci.yml` file provides a complete pipeline with:
- Parallel lint/style/coverage jobs
- **Auto-fix with air** (optional, manual trigger)
- Quality gate stage
- HTML report + trend tracking as artifacts
- Cobertura coverage integration

## The demo package

This package contains two files designed to showcase rsonar's detection:

- **`clean_code.R`** — 3 well-written, documented, and tested functions (`greet`, `fibonacci`, `bmi`)
- **`messy_code.R`** — 2 intentionally messy functions with:
  - Missing spaces around `=` and `{`
  - `T`/`F` instead of `TRUE`/`FALSE`
  - Lines exceeding 80 characters
  - `=` used instead of `<-` for assignment
  - No tests (coverage gap)

This mix ensures rsonar always detects issues, making it ideal for demonstrations.

## License

MIT
