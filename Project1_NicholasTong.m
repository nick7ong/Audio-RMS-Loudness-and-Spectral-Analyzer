%% MMI - 503/603 Project 1
% Assignment: Develop a set of audio analysis functions by generating the
% following audio signals: white noise, sine tone @ 1000 Hz, exponential 
% sine sweep and analyze them


% Author : Nicholas Tong
% Email: n.tong@miami.edu

%% Guided Portion
% Generate white noise signal
fs = 48000;
duration = 5;
t = 0:1/fs:duration;
white_noise = randn(size(t));

%figure;
%spectrogram(white_noise,128,64,512,fs);
%title("Randomly Generated White Noise");

% Generate sine tone @ 1000 Hz
f = 1000;
sine_tone = sin(2*pi*f*t);

%figure;
%spectrogram(sine_tone,128,64,512,fs);
%title("Sine Tone 1k Hertz");

% Generate exponential sine sweep (ESS)
f0 = 100;
f1 = 20000;
exp_sine_sweep = chirp(t,f0,t(end),f1,'logarithmic');

%figure;
%spectrogram(exp_sine_sweep,128,64,512,fs);
%title("Exponential Sine Sweep 20 to 20k Hertz");

% Create a separate function file that analyzes the root-mean squared
% loudness in decibels


% Create a separate function file that analyzes the spectral content and
% returns the magnitude in decibels and frequency bin values


%% Analytical directions
% Loop through the signals using a buffer size of 4096 and an overlap of
% 2048 and analyze the loudness and spectral content on each buffer using
% the functions created above. Plot the results over time.

% Buffer and overlap
buff_size = 4096;
overlap = 2048;

% Store the results in arrays
loudness_white_noise = [];
loudness_sine_tone = [];
loudness_exp_sine_sweep = [];
spectral_white_noise = [];
spectral_sine_tone = [];
spectral_exp_sine_sweep = [];

% Loop through the signals per buffer
for i = 1:overlap:length(white_noise) - buff_size
    % Analyze the loudness of the current buffer
    loudness_white_noise(end + 1) = rms_loudness(white_noise(i:i + buff_size - 1));
    loudness_sine_tone(end + 1) = rms_loudness(sine_tone(i:i + buff_size - 1));
    loudness_exp_sine_sweep(end + 1) = rms_loudness(exp_sine_sweep(i:i + buff_size - 1));
    
    % Analyze the spectral content of the current buffer
    spectral_white_noise(:, end + 1) = spectral_analyzer(white_noise(i:i + buff_size - 1));
    spectral_sine_tone(:, end + 1) = spectral_analyzer(sine_tone(i:i + buff_size - 1));
    spectral_exp_sine_sweep(:, end + 1) = spectral_analyzer(exp_sine_sweep(i:i + buff_size - 1));
    
end

% time array in seconds for x-axis
time_array = (0:length(loudness_white_noise) - 1) * (overlap) / fs;
% frequency spectrum array for y-axis
bin_size = (fs/2)/buff_size;
f_spectrum = 0:bin_size:fs/2;

% Plot the loudness over time for each signal
figure;
subplot(3, 1, 1);
plot(time_array, loudness_white_noise);
title('Loudness of White Noise');
ylabel('Loudness(dB)');
xlabel('Time(s)')
subplot(3, 1, 2);
plot(time_array, loudness_sine_tone);
title('Loudness of Sine Tone @ 1000 Hz');
ylabel('Loudness(dB)');
xlabel('Time(s)')
subplot(3, 1, 3);
plot(time_array, loudness_exp_sine_sweep);
title('Loudness of Exponential Sine Sweep');
ylabel('Loudness(dB)');
xlabel('Time(s)')

% Plot the spectral content over time for each signal
figure;
subplot(3, 1, 1);
imagesc(time_array, f_spectrum, 20*log10(spectral_white_noise));
title('Spectral Content of White Noise');
ylabel('Frequency(Hz)')
xlabel('Time(s)')
subplot(3, 1, 2);
imagesc(time_array, f_spectrum, 20*log10(spectral_sine_tone));
title('Spectral Content of Sine Tone @ 1000 Hz');
ylabel('Frequency(Hz)')
xlabel('Time(s)')
subplot(3, 1, 3);
imagesc(time_array, f_spectrum, 20*log10(spectral_exp_sine_sweep));
title('Spectral Content of Exponential Sine Sweep');
ylabel('Frequency(Hz)')
xlabel('Time(s)')

%% Creative directions
% Analyze the loudness and sprecturum of a wav file of the your choice both
% the whole signal and per buffer and plot the results over time.

[sample_song,fs] = audioread('sample_song.wav');
player = audioplayer(sample_song,fs);

loudness_sample_song = [];
spectral_sample_song = [];

for i = 1:overlap:length(sample_song)- buff_size
    % Analyze the loudness of the current buffer
    loudness_sample_song(end + 1) = rms_loudness(sample_song(i:i + buff_size - 1));
    
    % Analyze the spectral content of the current buffer    
    spectral_sample_song(:, end + 1) = spectral_analyzer(sample_song(i:i + buff_size - 1));
end

time_array_new = (0:length(loudness_sample_song) - 1) * (overlap) / fs;

figure;
subplot(2, 1, 1);
plot(time_array_new, loudness_sample_song);
title('Loudness of Sample Song');
ylabel('Loudness(dB)')
xlabel('Time(s)')
subplot(2, 1, 2);
imagesc(time_array_new, f_spectrum, 20*log10(spectral_sample_song));
ylabel('Frequency(Hz)')
xlabel('Time(s)')
