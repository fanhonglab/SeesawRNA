%%*************************************************************************%%
%*************************************************************************** 
%*****                                                **********************
%*****                                                **********************
%*****   Hong Lab: seesaw RNA switch design           **********************
%*****                                                *********************
%*****                                                *********************
%************************************************************************%%
%%***********************************************************************%%



addpath("Lib");

Small_molecule_RNA_info = readtable('input/RNA_target_input.xlsx');

for c1 = 1:size(Small_molecule_RNA_info,1)

    target_name = Small_molecule_RNA_info.Targets{c1};
    aptamer_seq = Small_molecule_RNA_info.RNAAptamer{c1};

    design_list = ScriptGen(target_name,aptamer_seq);
    ScriptRun(design_list);
    seesaw_RNA_switch_seq = DesignSelect(design_list);
    writeCSVFilefromStructure(sprintf('Output/%s_design.csv',target_name),seesaw_RNA_switch_seq);
end







