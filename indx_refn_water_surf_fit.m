%% indx_refn_water_surf_fit.m
%  Reads an Excel file containing 3 columns: 1) temp (deg C); 2) wavelength
%  (nm); and 3) index of refraction, n of water. The table was generated
%  from Mobley (2010), which, in turn, contains data compiled from Austin
%  and Halikas (1976). The column headings are: 'Temp', 'Wavelength', and
%  'Index_Refr'. Performs polynomial surface fitting using the following 
%  function: z = a*x^2 + b*y^2 + c*x + d*y + e, where x is Temp, y is
%  Wavelength, and z is index of refraction. Plots the surface and writes
%  the coefficients (a, b, c, d, e) to the screen. I ran this script on two
%  separate input Excel files--one containing the freshwater (S = 0) values 
%  and the other containing the seawater (S = 35 per mille) values from 
%  Mobley (2010). 
%
%  Christopher Parrish (Christopher.Parrish@oregonstate.edu) 5/24/2020
%%
clear all; close all; clc

%% Input table (colums of temp, wavelength, refractive index
inputDataFile = strcat('E:\mobley_table_freshwater_columized.xlsx');

%% Read the data file
mobleyTable = readtable(inputDataFile);

%% Copy data from the table to variables x_, y_, and z_data
x_data = mobleyTable.Temp;
y_data = mobleyTable.Wavelength;
z_data = mobleyTable.Index_Refr;

%% Perform surface fitting. (Note: this section of code was auto-generated
% using the MATLAB Curve Fitting Toolbox.)
[xData, yData, zData] = prepareSurfaceData( x_data, y_data, z_data );

% Set up fittype and options.
ft = fittype( 'a*x^2 + b*y^2 + c*x + d*y + e', 'independent', ...
    {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.712003992522508 0.899925914724592 ...
    0.0750758360407583 0.141886338627215 0.421761282626275];

%% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

%% Plot fit with data.
figure
h = plot( fitresult, [xData, yData], zData );
legend( h, 'Surface fit', 'Refractive index vs. temp, wavelength', ...
    'Location', 'NorthEast', 'Interpreter', 'none' );
title('Refractive Index Surface Fit')
xlabel('Temperature (deg C)')
ylabel('Wavelength (nm)')
zlabel('Index of Refraction')
view([-129 32])

%%  Display the coefficients of the fit
format long
disp('Coefficients (a, b, c, d, e):')
coeffvalues(fitresult)