function dy = kinetics_riboswitch_without_target(t,y)

% RNA_complex_off --> RNA_complex_on, k_on1 , dG = 1 kcal/mol

dy=zeros(3,1);

RNA_complex_off = 1;
RNA_complex_on = 2;

T = 310;
R = 8.314;

dG1 = y(3);

k_on = 10^5;
k_off = k_on*2.718^(dG1*4.18*1000/(R*T));

dy(RNA_complex_off) = -k_on*y(RNA_complex_off)+k_off*y(RNA_complex_on);
dy(RNA_complex_on) = k_on*y(RNA_complex_off)-k_off*y(RNA_complex_on);













