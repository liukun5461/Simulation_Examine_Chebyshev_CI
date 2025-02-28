
# This script conducts a simulation study to evaluate the coverage probability of Chebyshev's confidence intervals for a binomial proportion. The study involves:
# 1. Generating random samples from a Binomial(n, p) distribution with p = 0.4.
# 2. Constructing Chebyshev confidence intervals for the estimated proportion.
# 3. Repeating the process across various sample sizes (n) ranging from 1 to 10,000.
# 4. Calculating the proportion of intervals that contain the true proportion (coverage probability) for each sample size.
# 5. Plotting the coverage probability and interval length against sample size.
# 6. Determining the minimum sample size required to achieve a desired interval length.

# set the coding environment
rm(list = objects()); gc()   # empty the global environment

options(
  java.parameters = c(
    "-XX:+UseG1GC",
    "-Xms3072m"
  )
) # Allocates more heap space for Java and uses a different garbage collector.


if(!require( "pacman")){
  install.packages("pacman")
}    # prepare package which helps package loading

pacman::p_load(
  ggplot2) # load necessary packages

# set the seed for reproducibility
set.seed(567)

# Parameter setting  
  
N <- seq(1,10000, by = 50)  # a sequence of sample size
repetition <- 50 # for each binomial setting repeat 50 times
p <- 0.4 #Probability of success in the Binomial distribution
alpha.level<-0.05

CP = array(0, length(N)) # vector of proportion that cover the true probability 
CL = array(0, length(N)) # vector of mean interval length

for (k in 1:length(N)){
  n = N[k] # go through different sample size
  X = rbinom(repetition,n,p) # repeat the randomization for repetition = 50 times
  p.hat<-X/n # a vector of estimates of p
  
  ## Construct the CI using Chebyshev's inequality.
  margin <- sqrt(log(2/alpha.level)/(2*n)) 
  MX = p.hat+margin  # vector of upper bounds
  MN = p.hat-margin # vector of lower bounds
  
  ## Determine which intervals cover EX=1.
  ci = ((MN <= p) & (MX >= p)) # vector of 0s and 1s indicating whether true value coverd by CI
  cl = 2*margin # vector of CI lenghts
  
  ## Calculate the proportion of intervals that cover.
  CP[k] = mean(ci) # cover rate for the specific sample size stored in CP
  CL[k] = mean(cl) # mean length for the specific sample size stored in CL
}

results <- data.frame(N, CP, CL)

# Plot the coverage probabilities against the sample sizes
ggplot(results, aes(x = N, y = CP)) +
  geom_line(color = "blue") +
  geom_hline(yintercept = 0.95, linetype = "dashed", color = "red") +
  labs(title = "Coverage Probability vs. Sample Size",
       x = "Sample Size",
       y = "Coverage Probability") +
  theme_minimal()

# Plot the interval lengths against the sample sizes
ggplot(results, aes(x = N, y = CL)) +
  geom_point(color = "black") +
  labs(title = "Confidence Interval Length vs. Sample Size",
       x = "Sample Size",
       y = "Interval Length") +
  ylim(0,1) +
  theme_minimal()

# plot(N,CP,type = "l",lwd = 3, ylim = c(0.8,1),las = 1)
# abline(h = 0.95,col = "red",lwd = 3)
# 
# plot(N,CL,lwd = 3, ylim = c(0,1),las = 1)
# abline(h = 0.05,col = "red",lwd = 3)
  
# Determine the minimum sample size required for the confidence interval length to be below a desired threshold
desired_length <- 0.1  # Define the desired maximum interval length
min_sample_size <- min(results$N[results$CL <= desired_length])

# Output the minimum sample size
cat("The minimum sample size required for the confidence interval length to be below", desired_length, "is", min_sample_size, "\n")
