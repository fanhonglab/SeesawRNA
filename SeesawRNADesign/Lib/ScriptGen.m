function design_list =ScriptGen(target_name,aptamer_seq)
    
    RNA_binding_domain = aptamer_seq;
    Aptamer_seq = sprintf('G%sC',RNA_binding_domain);

    GFPmut3b = dna2rna('ATGCGTAAAGGAGAAGAACTTTTCACTGGAGTTGTCCCAATTCTTGTTGAATTAGATGGTGATGTTAATGGGCACAAATTTTCTGTCAGTGGAGAGGGTGAAGGTGATGCAACATACGGAAAACTTACCCTTAAATTTATTTGCACTACTGGAAAACTACCTGTTCCGTGGCCAACACTTGTCACTACTTTCGGTTATGGTGTTCAATGCTTTGCGAGATACCCAGATCACATGAAACAGCATGACTTTTTCAAGAGTGCCATGCCCGAAGGTTACGTACAGGAAAGAACTATATTTTTCAAAGATGACGGGAACTACAAGACACGTGCTGAAGTCAAGTTTGAAGGTGATACCCTTGTTAATAGAATCGAGTTAAAAGGTATTGATTTTAAAGAAGATGGAAACATTCTTGGACACAAATTGGAATACAACTATAACTCACACAATGTATACATCATGGCAGACAAACAAAAGAATGGAATCAAAGTTAACTTCAAAATTAGACACAACATTGAAGATGGAAGCGTTCAACTAGCAGACCATTATCAACAAAATACTCCGATTGGCGATGGCCCTGTCCTTTTACCAGACAACCATTACCTGTCCACACAATCTGCCCTTTCGAAAGATCCCAACGAAAAGAGAGACCACATGGTCCTTCTTGAGTTTGTAACCGCTGCTGGGATTACACATGGCATGGATGAACTATACAAAAGGCCTGCAGCAAACGACGAAAACTACGCTGCATCAGTTTAATAA');
    
    rev_toehold = 'ACAU';
    loop_region = 'CAUAGAGGAGAUACAGA';
    linker_21 = 'GAACAAGAACUCCGACAAAUC';

    added_rev_toehold_len_set = 1:9;
    
    design_list = {};

    for c2 = 1:length(added_rev_toehold_len_set)

        added_rev_toehold_len = added_rev_toehold_len_set(c2);
        invade_bm_region = 17-added_rev_toehold_len;
        
        Trp_aptamer_structure = DotBracket2DUnotation(checkMFEstruc1999(Aptamer_seq));
        ribo_switch_structure = sprintf('U3 U%d U3 U%d U3 D21( U17 ) U21 U30',invade_bm_region,length(Aptamer_seq));
        
        file_name = sprintf('NUPACKscripts/%s_Add_Rev%dnt.txt',target_name,added_rev_toehold_len);

        design_list(end+1,:) = {sprintf('NUPACKscripts/%s_Add_Rev%dnt',target_name,added_rev_toehold_len)};
        fid = fopen(file_name,'w');
        
        fprintf(fid,'material = rna\n');
        fprintf(fid,'temperature = 37 \n\n');
         
        fprintf(fid,'domain preGGG = GGG\n');
        fprintf(fid,'domain aptamer = %s\n',Aptamer_seq);
        fprintf(fid,'domain fwd_toehold = CAU \n');
        fprintf(fid,'domain rev_toehold = %s \n',rev_toehold);
        fprintf(fid,'domain rev_toehold_add = N%d \n',added_rev_toehold_len);
        fprintf(fid,'domain bm_region = N%d\n',invade_bm_region);
        fprintf(fid,'domain loop_region = %s\n',loop_region);
        fprintf(fid,'domain linker_region = %s \n',linker_21);
        fprintf(fid,'domain GFP_30 = %s \n\n',GFPmut3b(1:30));
        
        fprintf(fid,'strand ribo_switch_0 = preGGG bm_region* fwd_toehold* aptamer fwd_toehold bm_region rev_toehold_add rev_toehold loop_region rev_toehold* rev_toehold_add* bm_region* linker_region GFP_30\n'); % target1 is wt
        fprintf(fid,'complex ribo_switch = ribo_switch_0 \n'); % target1 is wt
        fprintf(fid,'ribo_switch.structure = %s \n\n',ribo_switch_structure); % target1 is wt
        
        fprintf(fid,'stop[%%] = 40 \n'); % target1 is wt

    end

end







