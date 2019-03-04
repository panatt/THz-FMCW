%%----本程序用于批量读取特定文件夹下SynViewScan 300系统的*.csv文件数据
%%----王天一
%%----2018.11.27
%%----由于没有善用内置的csvread函数，导致程序过于冗长。

tic
% 0.清场-------------------------------------------------------------------
close all;
clear all;
clc;
disp('Reading Inormlinear data in csv files ...');
% 1.指定一个文件夹，并规定文件后缀csv----------------------------------------
fileType = '*.csv';
dirCSV = 'D:\SynViewSW\SynViewData\THz FMCW Deconvolution\20181205(2)\'
% 2.获取文件夹中*.csv文件的信息----------------------------------------------
list = dir([dirCSV,fileType]);
len = length(list) ;
% 3.读取它们的数据----------------------------------------------------------

for n=1:len
	fileName = strcat(dirCSV, list(n).name);
	fid=fopen(fileName,'r');                                               %以只读形式打开文件                            
    
    for numHeaders=1:5   %文件头共5行
    line_str=fgetl(fid);
    eval([strcat('header',num2str(numHeaders)),'=line_str;']); %读取文件头信息
    end
    line_str=fgetl(fid);  %数据表头
    numPoints=0;
    data=[];
    while feof(fid)==0
      numPoints=numPoints+1;
      data_str=fgetl(fid);
      a=str2num(data_str);
      data=cat(1,data,a);
    end
    data_Inormlinear(:,n) = data(:,6);  %感兴趣的数据在csv中第6列
    fclose(fid);   
end
zmm = data (:,2)';% 距离坐标
disp('Mission Completed');
toc





















