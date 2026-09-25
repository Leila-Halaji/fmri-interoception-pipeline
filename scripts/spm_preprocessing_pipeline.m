spm('defaults','FMRI');
spm_jobman('initcfg');

data_dir = 'C:\Users\leyla\Documents\fmri-project\data\ds003763\sub-09113';
func_dir = fullfile(data_dir,'func');
anat_dir = fullfile(data_dir,'anat');
func_file = fullfile(func_dir,'sub-09113_task-heart_bold.nii');
anat_file = fullfile(anat_dir,'sub-09113_T1w.nii');

V = spm_vol(func_file);
nvols = numel(V);
fprintf('Functional file has %d volumes.\n', nvols);
func_frames = cell(nvols,1);
for i = 1:nvols
    func_frames{i} = sprintf('%s,%d', func_file, i);
end

%% STEP 1: Realign: Estimate & Reslice
clear matlabbatch
matlabbatch{1}.spm.spatial.realign.estwrite.data = {func_frames};
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
spm_jobman('run', matlabbatch);

r_file = fullfile(func_dir, 'rsub-09113_task-heart_bold.nii');
Vr = spm_vol(r_file);
fprintf('Realigned file has %d volumes.\n', numel(Vr));

%% STEP 2: Slice Timing
r_frames = cell(numel(Vr),1);
for i = 1:numel(Vr)
    r_frames{i} = sprintf('%s,%d', r_file, i);
end
slice_timing_ms = [1002.5,0,1057.5,55,1115,110,1170,165,1225,222.5, ...
    1282.5,277.5,1337.5,332.5,1392.5,390,1450,445,1505,500, ...
    1560,557.5,1615,612.5,1672.5,667.5,1727.5,725,1782.5,780, ...
    1840,835,1895,890,1950,947.5];

clear matlabbatch
matlabbatch{1}.spm.temporal.st.scans = {r_frames};
matlabbatch{1}.spm.temporal.st.nslices = 36;
matlabbatch{1}.spm.temporal.st.tr = 2;
matlabbatch{1}.spm.temporal.st.ta = 1.9444;
matlabbatch{1}.spm.temporal.st.so = slice_timing_ms;
matlabbatch{1}.spm.temporal.st.refslice = 0;
matlabbatch{1}.spm.temporal.st.prefix = 'a';
spm_jobman('run', matlabbatch);

ar_file = fullfile(func_dir, 'arsub-09113_task-heart_bold.nii');

%% STEP 3: Coregister (Estimate)
mean_file = fullfile(func_dir, 'meansub-09113_task-heart_bold.nii');
clear matlabbatch
matlabbatch{1}.spm.spatial.coreg.estimate.ref = {anat_file};
matlabbatch{1}.spm.spatial.coreg.estimate.source = {mean_file};
spm_jobman('run', matlabbatch);

%% STEP 4: Segment
clear matlabbatch
matlabbatch{1}.spm.spatial.preproc.channel.vols = {anat_file};
matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];
spm_jobman('run', matlabbatch);

y_file = fullfile(anat_dir, 'y_sub-09113_T1w.nii');

%% STEP 5: Normalise: Write (on functional)
Var = spm_vol(ar_file);
ar_frames = cell(numel(Var),1);
for i = 1:numel(Var)
    ar_frames{i} = sprintf('%s,%d', ar_file, i);
end
clear matlabbatch
matlabbatch{1}.spm.spatial.normalise.write.subj.def = {y_file};
matlabbatch{1}.spm.spatial.normalise.write.subj.resample = ar_frames;
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
spm_jobman('run', matlabbatch);

war_file = fullfile(func_dir, 'warsub-09113_task-heart_bold.nii');

%% STEP 6: Smooth
Vwar = spm_vol(war_file);
war_frames = cell(numel(Vwar),1);
for i = 1:numel(Vwar)
    war_frames{i} = sprintf('%s,%d', war_file, i);
end
clear matlabbatch
matlabbatch{1}.spm.spatial.smooth.data = war_frames;
matlabbatch{1}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{1}.spm.spatial.smooth.prefix = 's';
spm_jobman('run', matlabbatch);

final_file = fullfile(func_dir, 'swarsub-09113_task-heart_bold.nii');
Vfinal = spm_vol(final_file);
fprintf('FINAL file has %d volumes (should equal %d).\n', numel(Vfinal), nvols);
