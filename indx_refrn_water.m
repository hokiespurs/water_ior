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
%% Compute n
indxRefn = a*temp^2 + b*wavelength^2 + c*temp + d*wavelength + e;