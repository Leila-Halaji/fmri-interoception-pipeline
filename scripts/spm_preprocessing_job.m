%-----------------------------------------------------------------------
% Job saved on 24-Sep-2026 15:13:19 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.normalise.write.subj.def = {'C:\Users\leyla\Documents\fmri-project\data\ds003763\sub-09113\anat\y_sub-09113_T1w.nii'};
matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {'C:\Users\leyla\Documents\fmri-project\data\ds003763\sub-09113\func\arsub-09113_task-heart_bold.nii,1'};
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
matlabbatch{2}.spm.spatial.smooth.data = {'C:\Users\leyla\Documents\fmri-project\data\ds003763\sub-09113\func\warsub-09113_task-heart_bold.nii,1'};
matlabbatch{2}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{2}.spm.spatial.smooth.dtype = 0;
matlabbatch{2}.spm.spatial.smooth.im = 0;
matlabbatch{2}.spm.spatial.smooth.prefix = 's';
