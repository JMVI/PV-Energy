% ------------------------------------------------------------------------------
% Copyright (C) 2021 Jaime M. Villegas I. <jaime7592@gmail.com>
% ------------------------------------------------------------------------------
% Filename      : Single_diode_PV_cell.m
% Description   : Solving I-V equation of a non-ideal solar cell using the
%                 single diode equivalent model.
% Version       : 01.00
% Revision      : 00
% Last modified : 03/21/2021
% ------------------------------------------------------------------------------
clear
clc

% Physical constants
q = 1.602e-19;                % Elemental charge [C]
kB = 1.3806e-23;              % Boltzmann constant [J/K]

% PV cell parameters
n = 1;                             % Ideality factor [-]
Rs = [0.0 2.5 5.0 7.0 10.0];       % Series resistance [Ohm]
Rp = [1e-3 5e-3 10e-3 30e-3 1e4];  % Parallel resistance [Ohm]
T = 300;                           % Temperature [K]
V = 0:0.01:1;                      % Cell voltage [V]
Io = 22e-12;                       % Saturation current [A]
Iph = 10e-3;                       % Photocurrent [A]
I_range = [-1000 1000];                  % Cell current range [A]

I = zeros(1, length(V));           % Cell current [A]

% Cell equation
for i = 1:length(Rp)
  for j = 1:length(Rs)
    for k = 1:length(V)
      I_eq = @(I) ( I - (Io*(exp(q*(V(k) - I*Rs(j))/(n*kB*T)) - 1) + ... 
                   ( V(k) - I*Rs(j) )/Rp(i) - Iph) );
      
      I(k) = fzero(I_eq, I_range);
    end
  end
end
