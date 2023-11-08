close all;
img = dicomread("cv07_DICOM_aktivni_kontury\cv07_DICOM_aktivni_kontury\ctslice.dcm");
info = dicominfo("cv07_DICOM_aktivni_kontury\cv07_DICOM_aktivni_kontury\ctslice.dcm");
img = mat2gray(img); 
subplot 131; imshow(img);

img2 = dicomread("cv07_DICOM_aktivni_kontury\cv07_DICOM_aktivni_kontury\slice2.dcm");
img2 = mat2gray(img2); 
subplot 132; imshow(img2);

img3 = dicomread("cv07_DICOM_aktivni_kontury\cv07_DICOM_aktivni_kontury\MR-MONO2-8-16x-heart");
img3 = mat2gray(img3); 
subplot 133;montage(img3)



subplot 131;mask = roipoly(img);
kontury = activecontour(img, mask,500,"Chan-vese");
kontury = imfill(kontury,"holes");
a = img + kontury;
subplot 131; imshow(a);

subplot 132;mask2 = roipoly(img2);
kontury2 = activecontour(img2, mask2,500);
subplot 132; imshow(img2 + kontury2);

%%

clear
close all;
load mri.mat
D = ind2gray(D,map);
D = squeeze(D);
subplot 131; imshow(D(:,:,3));
a = squeeze(D(:,50,:));
a = imresize(a,[128,128]);
subplot 132; imshow(a);
b = squeeze(D(40,:,:));
b = imresize(b,[128,128]);
subplot 133; imshow(b)








