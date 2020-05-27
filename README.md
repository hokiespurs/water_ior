# water_ior
Chris Parrish (2020)

Use this empirical model to estimate the refractive index of freshwater and saltwater.  Data for the empirical model are from data published by Mobley (2010), which were based on data from Austin and Halikas (1976).

![n = aT^2 + b \lambda^2 + cT + d \lambda + e](https://render.githubusercontent.com/render/math?math=n%20%3D%20aT%5E2%20%2B%20b%20%5Clambda%5E2%20%2B%20cT%20%2B%20d%20%5Clambda%20%2B%20e)

![n](https://render.githubusercontent.com/render/math?math=n) = index of refraction

![T](https://render.githubusercontent.com/render/math?math=T) = temperature in degrees Celcius (valid range: 0-30)

![\lambda](https://render.githubusercontent.com/render/math?math=%5Clambda) = wavelength in nm (valid range 400-700 ~ visible spectrum)

| Coefficient | Seawater (S = 35‰) | Freshwater (S = 0) |
|-------------|--------------------|--------------------|
| a           | -1.50156×10-6      | -1.97812×10-6      |
| b           | 1.07085×10-7       | 1.03223×10-7       |
| c           | -4.27594×10-5      | -8.58125×10-6      |
| d           | -1.60476×10-4      | -1.54834×10-4      |
| e           | 1.39807            | 1.38919            |

### Code snippet
While a matlab script is provided, below is a quick snippet of code for matlab and python.
#### Seawater Constants
```python
a = -0.000001501562500
b = 0.000000107084865
c = -0.000042759374989
d = -0.000160475520686
e = 1.398067112092424
```

#### Freshwater Constants
```python
a = -0.000001978124999
b = 0.000000103223477
c = -0.000008581249990
d = -0.000154833692090
e = 1.389193029374634
```

#### Matlab Empirical Equation
```matlab
ior = a*temp.^2 + b.*wavelength.^2 + c.*temp + d.*wavelength + e;
```
#### Python Empirical Equation
```python
ior = a*temp**2 + b*wavelength**2 + c * temp + d * wavelength + e
```

## Background
While the internet might tell you that the refractive index of water is 1.33, it is actually a function of the wavelength of the light, as well as the salinity, temperature, and pressure of the water. If you are working with bathymetric lidar (λ = 532 nm, usually) or mapping bathymetry using structure from motion (SfM) photogrammetry, you probably don’t want to just use this generic, approximate value of 1.33. (If you're working in seawater and just need an approximate value for the visible spectrum, 1.34 is a better approximation than 1.33.)

## Methods
I developed the equation and coefficients above by reading tabulated values of the index of refraction from Mobley (2010) into MATLAB and doing surface fitting. The R2 values of my surface fits were 0.998, with the RMSEs being on the order of 2×10-4 for both seawater and freshwater. MATLAB surface plots are shown below:

![Surface Fit](https://github.com/hokiespurs/water_ior/blob/master/refractive_index_surface_plots.jpg)

The tabulated values used as input to this process are from Mobley (2010), which, in turn, are based on Austin and Halikas (1976), which, in turn, included data compiled from a variety of sources (all referenced therein). For anyone who wants to delve further into the index of refraction of seawater as a function of salinity, temperature, and pressure (with the latter not considered here), the Austin and Halikis paper is an excellent reference. There are likely newer and more accurate data than used in this 1976 study, but I haven’t found a clearer or more informative treatment of the subject. Note that greater precision in the value of n can be obtained by interpolating the tabulated values in Austin and Halikis (1976) than by using the equation above.

## References
> Austin, R.W., and G. Halikas, 1976. The Index of Refraction of Seawater. SIO Ref. No. 76-1, Scripps Institution of Oceanography. San Diego, California.

> Mobley, C.D. 2010. The optical properties of water. In Handbook of Optics (Eds. M. Bass), 3rd edition. McGraw-Hill, New York, Vol. 4, pp. 1.3–1.53.
