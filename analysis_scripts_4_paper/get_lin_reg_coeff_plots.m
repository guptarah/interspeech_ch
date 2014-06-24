function get_lin_coeff_plots()
filler_coefs=load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/smoothing/linear_reg/filler_training_matrix_50.coeff');
laughter_coefs=load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/smoothing/linear_reg/laughter_training_matrix_100.coeff');

close all;
%plotting the coefficients
subplot(2,1,1);
plot(-100:100,laughter_coefs(1:201),'-r');
hold on;
plot(-100:100,(1/201)*ones(1,201),'--b');
xlabel('Index m_{u} for linear filter coeffiecients');
ylabel('Coefficient value');
legend('MMSE','MA');
title('(a)')

subplot(2,1,2);
plot(-50:50,filler_coefs(1:101),'-r');
hold on
plot(-50:50,(1/101)*ones(1,101),'--b');
xlabel('Index m_{u} for linear filter coeffiecients');
ylabel('Coefficient value');
title('(b)')

% plotting the FFT
laugh_y =  fft(laughter_coefs(1:201));
laugh_y_ma = fft((1/201)*ones(1,201));
figure;
subplot(2,1,1);
plot(0:200,abs(laugh_y),'r');
ylim([-0.1 2]);
xlabel('Index values p for filter frequency response');
ylabel('|A_p|');
hold on
plot(0:200,abs(laugh_y_ma),'-b');
ylim([-0.1 2]);
legend('MMSE','MA');
title('(a)');


filler_y =  fft(filler_coefs(1:101));
filler_y_ma = fft((1/101)*ones(1,101));
subplot(2,1,2);
plot(0:100,abs(filler_y),'r');
ylim([-0.1 2]);
hold on
plot(0:100,abs(filler_y_ma),'-b');
ylim([-0.1 2]);
title('(b)');
xlabel('Index values p for filter frequency response');
ylabel('|A_p|');