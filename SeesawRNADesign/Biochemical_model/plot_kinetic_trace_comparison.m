
time_span = 0:0.1:60;
RNA_complex_off_0 = 1*10^-6;
t = 1:60;

dG1 = 5;
reaction_input = [RNA_complex_off_0,0,dG1];
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
[t,y] = ode23s(@kinetics_riboswitch_without_target,time_span,reaction_input,options);

WT_signal = y(:,2);

yield_set = [];
yield_set(end+1,:) = [dG1 WT_signal(end)/RNA_complex_off_0];
close all;

figure(2);
hold on;
plot(t,WT_signal*10^6,'linewidth',2);
xlabel('Time (s)');
ylabel('ON state (µM)');
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
box on;

dG2 = -10;
reaction_input = [RNA_complex_off,RNA_complex_on,target_concentration,dG1,dG2];
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
[t,y] = ode23s(@kinetics_riboswitch_with_target2,time_span,reaction_input,options);

WT_signal = y(:,2);

plot(t,WT_signal*10^6,'linewidth',2);
xlabel('Time (s)');
ylabel('ON state Fraction');
set(gca,'fontsize',24);
set(gca,'linewidth',1);
axis square;
box on;
legend('without target','with target','Location','southeast');
legend boxoff;
