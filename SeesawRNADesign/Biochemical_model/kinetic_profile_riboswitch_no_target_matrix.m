
mins = 10;
time_span = 0:0.1:1*mins;

RNA_complex_off_0 = 1*10^-6;
t = 1:60;

dG1_set = [-10:0.1:10];

dG2_set = [-10:0.1:10];

yield_set = [];

xtick_labels = {};
ytick_labels = {};

for c1 = 1:length(dG1_set)
    
    dG1 = dG1_set(c1);
    
    xtick_labels{end+1} = num2str(dG1);
    ytick_labels{end+1} = num2str(dG2_set(c1));
    fprintf('working on %d \n',c1);

    parfor c2 = 1:length(dG2_set)

        reaction_input = [RNA_complex_off_0,0,dG1];
        options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
        [t,y] = ode23s(@kinetics_riboswitch_without_target,time_span,reaction_input,options);
        
        bg_signal = RNA_complex_off_0*0.1;
        WT_signal = y(:,2);
        
        yield_set(c1,c2) = [WT_signal(end)/RNA_complex_off];   

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

    end

end

figure(1);
imagesc(yield_set)
xlabel('\DeltaG RNA-transition (kcal/mol)');
ylabel('\DeltaG RNA-target (kcal/mol)');
xticks([0:20:200]);
xticklabels(xtick_labels(1:20:200));
yticks([0:20:200]);
yticklabels(ytick_labels(1:20:200));
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
box on;

writematrix(yield_set,'yield_set_without_target_matrix.txt');


