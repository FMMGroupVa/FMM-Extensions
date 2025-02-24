# FMM Extensions


This repository contains source code for implementing the multichannel multicomponent FMM model (3DFMM), including functions for model fitting, visualization, and parameter inference. The code is developed in the programming language R and a usage example is provided  in the `3DFMMUse.R` file. 

## Overview
The FMM (Frequency Modulated Möbius) model is a nonlinear parametric regression model designed to analyze nearly periodic, non-sinusoidal physiological time series, extracting key features encoded in time-varying oscillatory morphology. This method decomposes signals into harmonic functions, known as Möbius waves, which are characterized by four physiologically interpretable parameters: amplitude (
A
), location (
α
), width/sharpness (
ω
), and direction/symmetry (
β
).

The FMM approach has demonstrated its effectiveness across various fields, including cardiology, neuroscience, and circadian biology, among many others. Readers may refer to [1-3] for further details.
## How to use

### `fitMultiFMM` function description.

`fitMultiFMM` performs the estimation of a 3DFMM model .

#### Arguments

* `vDataMatrix`: double matrix. Each column contains the signal in a concrete direction.
* `nBack`: number of FMM components to be fitted.
* `maxIter`: maximum number of iterations for the backfitting algorithm.
* `lengthAlphaGrid`: number of values in the equally spaced grid for $\alpha$. By default, it is set to 48.
* `lengthOmegaGrid`: number of values in the equally spaced grid for $\omega$. By default, it is set to 24.
* `showPredeterminedPlot`: logical. Is the FMM model plotted after fitting?

If `vDataMatrix` columns are named, the names will be used to label the directions in the resulting plot. 

#### Return values
An `R` list. Each element of the list contains the estimated values of the FMM parameters in a concrete direction. 

Plot of the signal prediction and the fitted waves in the example data (`exampleData.csv`):

<p align="center">
  <img src="https://user-images.githubusercontent.com/117477025/215553083-31e7b77b-7d87-479f-a305-4445fadae784.jpg" width="900" height="700" alt>
</p>

### `confintFMM` function description.

Confidence intervals based on the asymptotic parameter covariance matrix proposed in [1].

#### Arguments
* `paramsPerSignal`: output of `fitMultiFMM` function.
* `vDataMatrix`: data matrix fitted. Used for the estimate of sigma.
* `confidenceLevel`: confidence level for the parameter intervals. By default, it is set to 0.95.

If `vDataMatrix` columns are named, and the confidence intervals for the parameters

#### Return values
Confidence intervals for each parameter. The FMM parameters **delta** and **gamma** are named as **parameter_component_direction**. Parameters **alpha** and **omega** are common along directions and they are named **parameter_component**.

Confidence interval (95%) for $\alpha$ and $\omega$ parameters (data: `exampleData.csv`):

|             | alpha_1 | alpha_2 | alpha_3 | alpha_4 | alpha_5 |
|-------------|:-------:|:-------:|:-------:|:-------:|:-------:|
| Lower (95%) | 5,7472  | 1,2705  | 5,8753  | 5,5872  | 4,3885  |
| Estimate    | 5,7518  | 1,2918  | 5,8822  | 5,5983  | 4,4431  |
| Upper (95%) | 5,7563  | 1,3131  | 5,8891  | 5,6093  | 4,4976  |


|             | omega_1 | omega_2 | omega_3 | omega_4 | omega_5 |
|-------------|:-------:|:-------:|:-------:|:-------:|:-------:|
| Lower (95%) | 0,0299  | 0,1823  | 0,0243  | 0,0284  | 0,1003  |
| Estimate    | 0,0318  | 0,1926  | 0,0272  | 0,0332  | 0,1279  |
| Upper (95%) | 0,0336  | 0,2029  | 0,0301  | 0,0380  | 0,1555  |







