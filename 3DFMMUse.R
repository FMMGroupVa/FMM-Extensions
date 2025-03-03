
# IMPORTANT: set the working directory to this file location 
# setwd("---/FMM-Extensions-main")

# Libraries for source code reading
source("auxMultiFMM.R") # Codes for 3DFMM estimation + CIs

# Simulated data with common sigma
exampleData <- read.csv("exampleData.csv")

################################################################################

# 1. Estimation of the parameters with -fitMultiFMM- function.

# Arguments: 
#     vDataMatrix - double matrix. Each column corresponds to a channel.
#     nBack - Number of FMM components to be fitted
#     maxIter - Maximum number of iterations for the backfitting estimation algorithm.

paramsPerSignal <- fitMultiFMM(vDataMatrix = exampleData, nBack = 5, maxIter = 5)

print(paramsPerSignal[[2]]) # Estimated parameters (Lead II)

################################################################################

# 2. FMM fitted values with -predictMultiFMM- function

# Arguments: 
#     vDataMatrix - Data matrix of dimension: number observations x number Channels
#     paramsPerSignal - output of fitMultiFMM function, containing fitted model parameters.

fittedValues <- predictMultiFMM(vDataMatrix = exampleData, paramsPerSignal = paramsPerSignal)

leadIIPrediction <- fittedValues[[2]] # Lead II fitted values

# Plot: Lead II observed data (black) and prediction (red)
plot(exampleData$II, type = "l")
lines(leadIIPrediction, type = "l", col = 2)

################################################################################

# 3. To show channels or a selection of channels use the -plotMultiFMM- function

# Arguments: 
#     vDataMatrix - Data matrix of dimension: number observations x number Channels
#     paramsPerSignal - output of fitMultiFMM function, containing fitted model parameters.
#     nPlotCols - number of columns in the grid layout for plotting.
#     channels - indices of the selected channels to be plotted.
#     components - (F) to plot the predicted signal or (T) individual components of the fitted signal


# User must give data matrix, parameters output, and specify what channels 
# are required and how to plot them:

# Fitted signal plots
plotMultiFMM(vDataMatrix = exampleData, paramsPerSignal = paramsPerSignal, 
             nPlotCols = 4, channels = 1:8, components = F)

# Component plots
plotMultiFMM(vDataMatrix = exampleData, paramsPerSignal = paramsPerSignal, 
             nPlotCols = 4, channels = 1:8, components = T)
################################################################################

# 4. Confidence intervales for FMM parameters

# Arguments: 
#     vDataMatrix - data matrix. Used for the estimate of sigma
#     paramsPerSignal - output of fitMultiFMM function
#     confidenceLevel - confidence level for the CIs

CIs <- confintFMM(vDataMatrix = exampleData, paramsPerSignal = paramsPerSignal,
                  confidenceLevel = 0.95)

print(round(CIs[,81:90],3)) # CIs for alphas and omegas

################################################################################

