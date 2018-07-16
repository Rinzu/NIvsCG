%----------------------------------------------------------------
%  Patch augmentation by cropping a certain number of image patches 
%  from each image using Maximal Poisson-disk Sampling (MPS)
%----------------------------------------------------------------
clc;
clear all;
kCropHeight = 240;  % the height of patch
kCropWidth = 240;  % the width of patch
kCropNum = 200;  % the number of cropped patches for each image
mps_data = load('mps/maxmps_200.pts');
rng('shuffle');  % used for randi

mainDir = "C:\Users\jalouam\Desktop\ML\NIvsCG\datasets\"
subDirs = ["personal"; "PRCG"]

for i = 1:2
    files = dir(strcat(mainDir, 'full\', subDirs{i})) %get all the image files in the directory 
    files = files(3:end) %ignore the '.' and '..' directories
    for k = 1:800 %go through all files in this folder
        imgName = files(k).name
        img = imread(imgName);
        pos_flag = zeros(4,1);  % four corners
        for x = 1:kCropNum
            [cut pos_flag]= imageMpsCrop(img, pos_flag, mps_data, x, kCropWidth, kCropHeight); % mps sampling
            image_name_split = strsplit(image_name, '.');
            imwrite(cut, strcat(image_name_split{1}, '-', num2str(x), '.', image_name_split{2}));
        end
    end
    
end

