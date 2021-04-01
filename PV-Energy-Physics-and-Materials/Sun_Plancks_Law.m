% ------------------------------------------------------------------------------
% Copyright (C) 2021 Jaime M. Villegas I. <jaime7592@gmail.com>
% ------------------------------------------------------------------------------
% Filename      : Sun_Plancks_Law.m
% Description   : Spectral radiance of the Sun using blackbody aproximation
%                 and Planck's Law.
% Version       : 01.00
% Revision      : 00
% Last modified : 03/15/2021
% ------------------------------------------------------------------------------
clear
clc

% Planck's law
T = [4000, 5000, 6000];       % Body temperature [K]
lambda = (1:3000)*1e-9;       % Wavelength [m]
lambda_nm = lambda/1e-9;      % Wavelength [nm]
h = 6.6261e-34;               % Planck's constant [Js]
kB = 1.3806e-23;              % Boltzmann constant [J/K]
c0 = 3e8;                     % Speed of light in vacuo

% Spectral radiance [Wm^2/nm sr]
for i = 1:length(T)
  Le_BB(i, :) = (2*h*c0^2./(lambda.^5) )./(exp( h*c0./( lambda*kB*T(i) ) ) - 1); 
end

% Sun Solid angle from Earth
R_Sun = 696340e3                             % Radius of the sun [m]
R_Earth = 6371e3                             % Radius of the Earth [m]
AU = 149597870700;                           % Astronomical unit [m]
Omega_Sun = pi*( R_Sun / (AU - R_Earth) )^2; % Solid angle [sr]

% Spectral irradiance [Wm^2/nm sr] 
Ie_BB = Le_BB*Omega_Sun;

% Plotting spectral radiance and spectral irradiance

% 1. Spectral radiance
subplot(2,1,1)
plot(lambda_nm, Le_BB(1, :), 'b', ...
     lambda_nm, Le_BB(2, :), 'g', ...
     lambda_nm, Le_BB(3, :), 'r')
xlabel('Wavelength (nm)')
ylabel('Spectral radiance (Wm^2/nm sr)')
legend('4000 K', '5000 K', '6000 K');

% 2. Spectral irradiance
subplot(2,1,2)
plot(lambda_nm, Ie_BB(1, :), 'b', ...
     lambda_nm, Ie_BB(2, :), 'g', ...
     lambda_nm, Ie_BB(3, :), 'r')
xlabel('Wavelength (nm)')
ylabel('Spectral radiance (Wm^2/nm)')
legend('4000 K', '5000 K', '6000 K');