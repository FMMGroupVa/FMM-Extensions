# FMM Extensions


This repository contains source code for implementing the multichannel multicomponent FMM model (3DFMM), including functions for model fitting, visualization, and parameter inference. The code is developed in the programming language R and a usage example is provided  in the `3DFMMUse.R` file. 

## Overview
The 3DFMM model is suitable for scenarios where $k$ sequential events are observed from $d$ different directions (or channels). The 3DFMM is described by a closed curve in 3D space, combining FMM waves (or components) lying in different planes, which are observed as projections on multiple directions. An FMM wave is a scaled Möbius wave characterized by four parameters: amplitude ($A$), location ($\alpha$), width/sharpness ($\omega$), and symmetry/peak direction ($\beta$). These four parameters are wave-specific, but while $A$ and $\beta$ are also channel-specific, $\alpha$ and $\omega$ remain consistent across channels establishing connectivity among signals from different channels which significantly simplifies the model. The alternative FMM wave parametrization $\delta = A\cos(\beta), \quad \gamma = -A\sin(\beta)$ is often used for a more intuitive geometric interpretation and ease of theoretical developments. For more in-depth details on 3DFMM, including model formulation, estimation algorithm, and inferential procedure, please refer to the original paper [1].  

The 3DFMM approach has demonstrated its efficiency in real-world scenarios, particularly in the field of bioelectrical signals as is the case of the electrocardiogram (ECG). Standard ECG signals consist of 12 different leads (channels), each representing the electrical activity of the heart from a different perspective [2].  The 3DFMM provides a robust framework for decomposing and analyzing this multichannel ($d=12$) multicomponent ($k=5$) signal ensuring the correspondence of the five components to the main ECG waves: P, Q, R, S, and T for typical ECG heartbeats. However, the utility of 3DFMM extends beyond ECG analysis. It can be applied to a wide range of multivariate signals, including electroencephalograms or electroretinograms, among many others [3,4].  

## How to use

The following functions outline the fundamental steps for implementing the 3DFMM model, visualizing predictions, and performing inference on 3DFMM parameters.

### `fitMultiFMM` function description.

`fitMultiFMM` performs the estimation of a 3DFMM model.

#### Arguments

* `vDataMatrix`: double matrix. Each column corresponds to a channel.
* `nBack`: number of FMM components to be fitted.
* `maxIter`: maximum number of iterations for the backfitting estimation algorithm.

If `vDataMatrix` columns are named, the names will be used to label the directions in the resulting plot. 

#### Return values
An `R` list with a length equal to the number of channels. Each element of the list is a  $k\times 5$ matrix, containing the estimated FMM parameters, including intercept $M$.

### `plotMultiFMM` function description.

`plotMultiFMM` generates customized plots for 3DFMM fitting and wave decomposition.

#### Arguments

* `vDataMatrix`: double matrix. Each column corresponds to a channel.
* `paramsPerSignal`: the output object from `fitMultiFMM`.
* `channels`: channel selection from columns in vDataMatrix to be shown.
* `components`: logical. If FALSE, the 3DFMM model fitting is displayed; if FALSE, the wave decomposition is performed.

#### Return
Plots of the signal predictions and the fitted waves.
Next figures illustrate 8-channel ECG predicted signal and wave decomposition for the example data `exampleData.csv`.

<p align="center">
  <img src="https://user-images.githubusercontent.com/117477025/215553083-31e7b77b-7d87-479f-a305-4445fadae784.jpg" width="900" height="700" alt>
</p>

### `confintFMM` function description.

Confidence intervals based on the asymptotic parameter covariance matrix proposed in [1].

#### Arguments
* `vDataMatrix`: double matrix. Each column corresponds to a channel.
* `paramsPerSignal`: output of `fitMultiFMM` function.
* `confidenceLevel`: confidence level for the parameter intervals. By default, it is set to 0.95.


#### Return values
A matrix containing confidence intervals and point estimates for the parameters $\delta$, $\gamma$, $\alpha$, and $\omega$. Note that there are $k \times d$ intervals for $\delta$ and $\gamma$, whereas for $\alpha$ and $\omega$, there are $k$ intervals.

Next, we present (95%) confidence intervals  for the example dataset `exampleData.csv`. Due to space limitations, only the intervals for $\alpha$ and $\omega$ parameters are displayed:

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

## References
[1] Rueda, C., Rodríguez-Collado, A., Fernández, I., Canedo, C., Ugarte, M. D., & Larriba, Y. (2022). A unique cardiac electrocardiographic 3D model. Toward interpretable AI diagnosis. *IScience, 25*(12).

[2] Fernández, I., Larriba, Y., Canedo, C. & Rueda, C. (2025) .Functional data analysis with Möbius waves: Applications to biomedical oscillatory signals. *Annals of Applied Statistics, To appear*.

[3] Canedo, C., Fernández-Santamónica, A., Larriba, Y., Fernández, I., & Rueda, C. (2023, October). Heart Attack Outcome Predictions Using FMM Models. In *2023 Computing in Cardiology (CinC)* (Vol. 50, pp. 1-4). IEEE.

[4] Canedo, C., Fernández, I., Coco, R. M., Cuadrado, R., & Rueda, C. (2023). Novel modeling proposals for the analysis of pattern electroretinogram signals. In *Statistical Methods at the Forefront of Biomedical Advances* (pp. 255-273). Cham: Springer International Publishing.




