# Modified Spline Regression

This is the repository for our paper titled "Modified Spline Regression for Neual Spiking Data" available on bioRxiv. 
Here we provide our MATLAB code for a simulated neural spiking data. 


### Code

The code is divided to four categoreis:

1. The [main.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/main.m) MATLAB file contains the main framework to run the experiment. 
2. The [SimulateSpike.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/SimulateSpike.m) file generates simulated neural spiking data
3. The [Hist.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/Hist.m) file is to build design matrix for multiplicative hisory model
4. The [Indicator.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/Indicator.m), [RaisedCos.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/RaisedCos.m), [CardinalSpline.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/CardinalSpline.m) and [ModifiedCardinalSpline.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/ModifiedCardinalSpline.m) are four basis functions that used for point process generalizes linear model (GLM). 

To run the model, you should clone all the files and run [main.m](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/main.m) file. 

### Results 

The following figure shows point process GLM fit using four different basis functions on the simulated data. 

![](https://github.com/MehradSm/Modified-Spline-Regression/blob/master/Bases.png)

And the following table represent the square root ratio (SRR) of the confidence interval width at the end point over the average of confidence interval width in the interior regions for four different bases. 

First Header | Indicator | Raised Cosine | Cardinsl Spline | Modified Cardinal Spline
----------   | --------- | ------------- | --------------- | ------------------------- 
SRR-start | 0.0063 | 1.355 | 2.364 | 1.244 
SRR-end | 0.014 | 0.831 | 1.598 | 0.970 
          
