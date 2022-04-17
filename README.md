# Modified Spline Regression

This is the repository for our paper titled "Modified Spline Regression for Neual Spiking Data" available on [PLOS ONE](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0258321). 
Here we provide our MATLAB code for a simulated neural spiking data. 

## Data
The data is available publicly on [CRCNS](http://dx.doi.org/10.6080/K02N50G9) data sharing page. 


## Code

The code is divided to four categoreis:

1. The [main.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/main.m) MATLAB file contains the main framework to run the experiment. 
2. The [SimulateSpike.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/SimulateSpike.m) file generates simulated neural spiking data
3. The [Hist.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/Hist.m) file is to build design matrix for multiplicative hisory model
4. The [Indicator.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/Indicator.m), [RaisedCos.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/RaisedCos.m), [CardinalSpline.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/CardinalSpline.m) and [ModifiedCardinalSpline.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/ModifiedCardinalSpline.m) are four basis functions that used for point process generalizes linear model (GLM). 

To run the model, you should clone all the files and run [main.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/main.m) file. 

## Results 

The following figure shows point process GLM fit using four different basis function on the simulated data. 

![](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/BasisFunctions.png)

In order to quantify the effect of the choice of basis function on the size of the confidence bounds, we computed a confidence interval width ratio (CIWR) of the confidence interval width at the end points over the average of confidence interval width in the interior regions for four different bases. 

First Header | Indicator | Raised Cosine | Cardinsl Spline | Modified Cardinal Spline
----------   | --------- | ------------- | --------------- | ------------------------- 
CIWR_start | 0.0047 | 1.183 | 20.152 | 1.119 
CIWR_end | 0.0104 | 0.641 | 2.682 | 1.264 
          
