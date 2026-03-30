time_span = 0:0.1:60;
RNA_complex_off_0 = 1*10^-6;
t = 1:60;

dG1_set = [-10:0.1:10];

yield_set_no_target = [];

for c1 = 1:length(dG1_set)

    dG1 = dG1_set(c1);
    reaction_input = [RNA_complex_off_0,0,dG1];
    options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
    [t,y] = ode23s(@kinetics_riboswitch_without_target,time_span,reaction_input,options);
    
    bg_signal = RNA_complex_off_0*0.03;
    WT_signal = y(:,2);
    
    yield_set_no_target(end+1,:) = [dG1 WT_signal(end)/RNA_complex_off_0];
    close all;

end

%% with targets
mins = 10;
time_span = 0:0.1:1*mins;
RNA_complex_off = 1*10^-6;
RNA_complex_int = 0;

target_concentration = 1*10^-3;
RNA_complex_on = 0;

dG1_set = [-10:0.1:10];
dG2 = -10;

yield_set_with_target = [];

for c1 = 1:length(dG1_set)
    
    dG1 = dG1_set(c1);
    
    reaction_input = [RNA_complex_off,RNA_complex_on,target_concentration,dG1,dG2];
    options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
    [t,y] = ode23s(@kinetics_riboswitch_with_target2,time_span,reaction_input,options);
    
    bg_signal = RNA_complex_off*0.03;
    WT_signal = y(:,2);
    
    yield_set_with_target(end+1,:) = [dG1 WT_signal(end)/RNA_complex_off];   
   
end

figure(1);
hold on;
plot(yield_set_no_target(:,1),yield_set_no_target(:,2),'LineWidth',2);
plot(yield_set_with_target(:,1),yield_set_with_target(:,2),'LineWidth',2);
xlabel('dG');
ylabel('ON state fraction');
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
box on; 

ON_OFF_ratio = (yield_set_with_target(:,2)+0.03)./(yield_set_no_target(:,2)+0.03);

figure(2);
hold on;
plot(yield_set_no_target(:,1),(yield_set_with_target(:,2)+0.03)./(yield_set_no_target(:,2)+0.03),'LineWidth',2);
xlabel('dG');
ylabel('ON state fraction');
set(gca,'fontsize',24);
set(gca,'linewidth',1);
axis square;
box on; 


compare_to_10 = abs(ON_OFF_ratio-10);

optimal_index = find(compare_to_10<0.55);

disp(yield_set_with_target(optimal_index,:));


