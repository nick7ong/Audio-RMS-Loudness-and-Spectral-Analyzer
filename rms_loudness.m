function loudness_db = rms_loudness(signal)
%% MMI - 503/603 Project 1
% Assignment: Develop an rms analyzer that returns the root-mean square in
% decibels
% Author : Nicholas Tong
% Email: n.tong@miami.edu

loudness = rms(signal);
loudness_db = 20*log10(loudness/20e-6);
end

