function [] = ScriptRun(design_list)  
% Enter the folder where the NUPACK design files are located:

% Enter design txt files that you want to run here:
% make sure not to include ".txt" extension in name

 design_files = design_list;

%specify folder in which to save the design zip files:
save_dir = 'NUPACKdesigns';

%specify number of interations to run the design file:
number_of_runs = 12;

%specify if you want to run on your local computer using multiple cores
IS_PARALLEL = 1;

%% Main code

mkdir(save_dir);
sim_info_set = {};

for c1 = 1:numel(design_files)
    script_name = design_files{c1};
    sub_save_dir = script_name;
    index = findstr('/',sub_save_dir);

    if ~isempty(index)
        sub_save_dir = sub_save_dir(index(1)+1:end);
    end

    [~,~,~] = mkdir([save_dir,'/',sub_save_dir]);

    for c2 = 1:number_of_runs
        sim_info_set(end+1,:) = {script_name,sub_save_dir,c2};
    end

    if IS_PARALLEL
        parfor c2 = 1:size(sim_info_set,1)
                design_folder = sim_info_set{c2,1};
                new_folder = sprintf('NUPACKdesigns/%s/',sim_info_set{c2,2});
                file_name = [sim_info_set{c2,1},'.txt'];
                new_file_name = [sprintf('%s/%s_%d',new_folder,sim_info_set{c2,2},c2),'.np'];    
                copyfile(file_name,new_file_name);

                system (sprintf('/Users/fanhong/Documents/software/nupack3.2.2/build/bin/multitubedesign %s',new_file_name));
                fprintf('**Design %s %d/%d is finished ...\n',sim_info_set{c2,2},c2,number_of_runs);
        end
    else
        for c2 = 1:size(sim_info_set,1)
                design_folder = sim_info_set{c2,1};
                new_folder = sprintf('NUPACKdesigns/%s/',sim_info_set{c2,2});
                file_name = [sim_info_set{c2,1},'.txt'];
                new_file_name = [sprintf('%s/%s_%d',new_folder,sim_info_set{c2,2},c2),'.np'];    
                copyfile(file_name,new_file_name);

                system (sprintf('/Users/fanhong/Documents/software/nupack3.2.2/build/bin/multitubedesign %s',new_file_name));
                fprintf('**Design %s %d/%d is finished ...\n',sim_info_set{c2,2},c2,number_of_runs);
        end
    end   
    sim_info_set = {};
end

