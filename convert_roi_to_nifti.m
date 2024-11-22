% Add MarsBar to your MATLAB path
addpath('/path/to/marsbar'); % Replace with the actual path to MarsBar
marsbar('on'); % Initialize MarsBar

% Specify the folder containing ROI .mat files
roi_folder = '/bgodata01/FRAP/RFX-Analysis_ICA-AROMA/ParkVideos/ANOVA/TwoFuturesPrePostBench/N19_no0040/Significant Clusters_p001k105';

% Get all *.roi.mat files in the folder
roi_files = dir(fullfile(roi_folder, '*roi.mat'));

% Check if any files were found
if isempty(roi_files)
    error('No ROI .mat files found in the specified folder: %s', roi_folder);
end

% Loop through each ROI file
for i = 1:length(roi_files)
    % Get the full file path
    roi_path = fullfile(roi_folder, roi_files(i).name);

    % Load the ROI file into MarsBar
    roi = maroi(roi_path);

    % Define the output NIFTI filename (same name as .mat file)
    [~, roi_name, ~] = fileparts(roi_files(i).name); % Extract the base name
    nifti_path = fullfile(roi_folder, [roi_name '.nii']);

    % Export the ROI to a NIFTI file
    saveroi(roi, nifti_path);
    fprintf('Converted %s to %s\n', roi_files(i).name, [roi_name '.nii']);
end

fprintf('All ROI files have been converted to NIFTI format.\n');