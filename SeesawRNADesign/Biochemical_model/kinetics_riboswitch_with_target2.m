function dy = kinetics_riboswitch_with_target2(t,y)

% RNA_complex_off + target --> RNA_complex_on, k_ass , dG2 = 1 kcal/mol

dy=zeros(5,1);

RNA_complex_off = 1;
RNA_complex_on = 2;
target = 3;

T = 310;
R = 8.314;

dG2 = y(5);
dG1 = y(4)+dG2;% target_aptamer_binding energy
% k_on = 10^5;
% k_off = k_on*2.718^(dG1*4.18*1000/(R*T));
k_ass = 1*10^3;
k_ass_off = k_ass*2.718^(dG1*4.18*1000/(R*T));

dy(RNA_complex_off) = -k_ass*y(RNA_complex_off)*y(target)+k_ass_off*y(RNA_complex_on);
dy(target) = -k_ass*y(RNA_complex_off)*y(target)+k_ass_off*y(RNA_complex_on);
dy(RNA_complex_on) = k_ass*y(RNA_complex_off)*y(target)-k_ass_off*y(RNA_complex_on);















