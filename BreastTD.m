close all;

clear all;
clc;
img=imread('BC.jpg');
bw=im2bw(img,0.7);
label=bwlabel(bw);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
se=strel('square',5);
tumor=imdilate(tumor,se);
figure();
subplot(1,3,1);
imshow(img);
title('Breast');
[B,L]=bwboundaries(tumor,'noholes');
imtool(tumor,[]);
subplot(1,3,2);
imshow(tumor);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'r' ,'linewidth',2.5);
end
hold off;
title('Tumor Alone');
[B,L]=bwboundaries(tumor,'noholes');
subplot(1,3,3);
imshow(img);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.5);
end

title('Detected Tumor');
hold off;