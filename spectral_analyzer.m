function freq_spectrum = spectral_analyzer(buffer)
%% MMI - 503/603 Project 1
% Assignment: Develop a spectral analyzer that returns the
% magnitude in decibels and frequency bin values 

% Author : Nicholas Tong
% Email: n.tong@miami.edu

X = abs(fft(buffer));
freq_spectrum = X(1:length(buffer)/2);
end

