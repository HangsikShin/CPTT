function [time, cPTT] = calculate_cPTT(sig1, sig2, Fs, BPFRANGE)
    % This is a function for calculating continuous pulse transit time using two photoplethysmograms
    % recording at different body sites
    %
    % Usage:
    % [time, cPTT] = calculate_cPTT(sig1, sig2, Fs, BPFRANGE)
    % 
    % Input arguments:
    % sig1: Photoplethysmogram measured at the first body site (e.g. finger tip)
    % sig2: Photoplethysmogram measured at the second body site (e.g. toe)
    % Fs: sampling frequency (e.g. 1000)
    % BPFRANGE: upper bound of frequency range of FIR bandpass filter (e.g.
    % 10)
    % 
    % Output arguments:
    % time: time of each sample in second
    % cPTT: value of CPTT in millisecond
    % 
    % Hangsik Shin, Ph.D. (hangsik.shin@gmail.com)
    %
    
    M = 0.1*Fs;
    b = ones(M,1)/M;
    analysis_length = 500; % milliseconds
    overlap_length = 1; % milliseconds
    
    time = (1:length(sig1))/Fs;

    sig1 = filtfilt(b,1, func_GaussianNorm(func_normalize01(func_FIRfilter(sig1, Fs, Fs, 0.5, BPFRANGE, 'bpf')))) ;
    sig2 = filtfilt(b,1, func_GaussianNorm(func_normalize01(func_FIRfilter(sig2, Fs, Fs, 0.5, BPFRANGE, 'bpf')))) ;

    [~, cPTT] = func_alignsignal(sig1, sig2, round((analysis_length)/1000*Fs), (overlap_length/1000)*Fs, Fs);

end



