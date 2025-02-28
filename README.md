# Chebyshev's Confidence Interval Simulation in R

## Overview

This project conducts a simulation study to evaluate the coverage probability of Chebyshev's confidence intervals for a binomial proportion. The study involves generating random samples from a Binomial distribution, constructing Chebyshev confidence intervals for the estimated proportion, and analyzing how the coverage probability and interval length vary with different sample sizes.

## Objectives

- **Simulate** random samples from a Binomial(n, p) distribution with a success probability `p = 0.4`.
- **Construct** Chebyshev confidence intervals for the estimated proportion.
- **Evaluate** the coverage probability of these intervals across various sample sizes ranging from 1 to 10,000.
- **Analyze** the relationship between sample size and both the coverage probability and interval length.

## Files

- `chebyshev_simulation.R`: The main R script that performs the simulation and analysis.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/chebyshev-ci-simulation.git
