yield_set_no_target = readmatrix('Simultation_output/yield_set_without_target_matrix.txt');

yield_set_with_target = readmatrix('Simultation_output/yield_set_with_target_matrix.txt');

bg_signal = 0.03;
ON_OFF_ratio_matrix = (yield_set_with_target+bg_signal)./(yield_set_no_target+bg_signal);

dG1_set = [-10:0.1:10];
dG2_set = [-20:0.1:0];

close all;
figure(1);
imagesc(yield_set_with_target);
title('With targets');
ylabel('\DeltaG RNA-transition (kcal/mol)');
xlabel('\DeltaG RNA-target (kcal/mol)');
yticks([0:20:200]);
yticklabels(dG1_set(1:20:200));
xticks([0:20:200]);
xticklabels(dG2_set(1:20:200));
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
colorbar;
box on;

figure(2);
imagesc(yield_set_no_target);
title('Without targets');
ylabel('\DeltaG RNA-transition (kcal/mol)');
xlabel('\DeltaG RNA-target (kcal/mol)');
yticks([0:20:200]);
yticklabels(dG1_set(1:20:200));
xticks([0:20:200]);
xticklabels(dG2_set(1:20:200));
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
colorbar;
box on;

figure(3);
imagesc(ON_OFF_ratio_matrix);
ylabel('\DeltaG RNA-transition (kcal/mol)');
xlabel('\DeltaG RNA-target (kcal/mol)');
yticks([0:20:200]);
yticklabels(dG1_set(1:20:200));
xticks([0:20:200]);
xticklabels(dG2_set(1:20:200));
set(gca,'fontsize',16);
set(gca,'linewidth',1);
axis square;
colorbar;
box on;

caxis([0 40]);
colorbar;
% 
% close all;
% figure(1);
% hold on;
% plot(yield_set_no_target.Var1,yield_set_no_target.Var2,'linewidth',2);
% plot(yield_set_with_target.Var1,yield_set_with_target.Var2,'linewidth',2);
% xlabel('\DeltaG (kcal/mol)');
% ylabel('ON state fraction');
% set(gca,'fontsize',20);
% set(gca,'linewidth',1);
% axis square;
% box on;
% legend('without target','with target','Location','southwest');
% legend boxoff;
% 
% bg_signal = 0.01;
% figure(2);
% 
% ON_OFF_ratio = (yield_set_with_target.Var2+bg_signal)./(yield_set_no_target.Var2+bg_signal);
% plot(yield_set_with_target.Var1,ON_OFF_ratio,'linewidth',2);
% set(gca,'fontsize',20);
% set(gca,'linewidth',1);
% xlabel('\DeltaG (kcal/mol)');
% ylabel('ON-OFF ratio');
% axis square;
% box on;
% 
% max_index = find(ON_OFF_ratio==max(ON_OFF_ratio));
% dG_max = yield_set_with_target.Var1(max_index);
% 
% 
% 
