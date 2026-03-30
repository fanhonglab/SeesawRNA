
mins = 10;
time_span = 0:0.1:1*mins;
RNA_complex_off = 1*10^-6;
RNA_complex_int = 0;

target_concentration = 1*10^-3;
RNA_complex_on = 0;

dG1_set = [-10:0.1:10]; % RNA-transition binding
dG2_set = [-20:0.1:0]; % RNA-target binding

yield_set = [];

xtick_labels = {};
ytick_labels = {};

for c1 = 1:length(dG1_set)
    
    dG1 = dG1_set(c1);
    
    xtick_labels{end+1} = num2str(dG1);
    ytick_labels{end+1} = num2str(dG2_set(c1));
    fprintf('working on %d \n',c1);
    parfor c2 = 1:length(dG2_set)

        dG2 = dG2_set(c2);
        
        reaction_input = [RNA_complex_off,RNA_complex_on,target_concentration,dG1,dG2];
        options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);
        [t,y] = ode23s(@kinetics_riboswitch_with_target2,time_span,reaction_input,options);
        
        bg_signal = RNA_complex_off*0.1;
        WT_signal = y(:,2);
        
        yield_set(c1,c2) = [WT_signal(end)/RNA_complex_off];   
        
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

writematrix(yield_set,'yield_set_with_target_matrix.txt');




