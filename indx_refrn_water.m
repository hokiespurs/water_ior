function indxRefn = indx_refrn_water(temp, wavelength, waterType)
%  Computes the index of refraction of seawater or freshwater. Uses
%  coefficients of a surface fit to tables in Mobley (2010), which, in 
%  turn, are based on Austin and Halikas (1976), which, in turn, includes 
%  data complied from a variety of sources (all referenced therein). 
%
%  Input:
%      temp : temperature in deg C
%      wavelength : wavelength in nm
%      waterType: 'f' = freshwater; 's' = saltwater
%  Output:
%      indxRefn : index of refraction
%      
%  Christopher.Parrish@oregonstate.edu 5/24/2020


%% Set coefficients, based on whether waterType is fresh or saltwater
if waterType == 's'
    a = -0.000001501562500;
    b = 0.000000107084865;
    c = -0.000042759374989;
    d = -0.000160475520686;
    e = 1.398067112092424;
elseif waterType == 'f'
    a = -0.000001978124999;
    b = 0.000000103223477;
    c = -0.000008581249990;
    d = -0.000154833692090;
    e = 1.389193029374634;
else
    disp('Not a valid water type. Valid types: s = saltwater, f = freshwater');
    return
end
%% Compute n (index of refraction)
indxRefn = a.*temp.^2 + b.*wavelength.^2 + c.*temp + d.*wavelength + e;

%% Warn if extrapolating data
if temp<0
    error('This empirical model should not be used for ice')
elseif temp>30
    warning('Warning: The temp is >30C, empirical model is extrapolating')
end
if wavelength<400
    warning('Warning: wavelength<400nm, empirical model is extrapolating')
elseif wavelength>700
    warning('Warning: wavelength>700nm, empirical model is extrapolating')
end
	