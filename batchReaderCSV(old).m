%%----����������������ȡ�ض��ļ�����SynViewScan 300ϵͳ��*.csv�ļ�����
%%----����һ
%%----2018.11.27
%%----����û���������õ�csvread���������³�������߳���

tic
% 0.�峡-------------------------------------------------------------------
close all;
clear all;
clc;
disp('Reading Inormlinear data in csv files ...');
% 1.ָ��һ���ļ��У����涨�ļ���׺csv----------------------------------------
fileType = '*.csv';
dirCSV = 'D:\SynViewSW\SynViewData\THz FMCW Deconvolution\20181205(2)\'
% 2.��ȡ�ļ�����*.csv�ļ�����Ϣ----------------------------------------------
list = dir([dirCSV,fileType]);
len = length(list) ;
% 3.��ȡ���ǵ�����----------------------------------------------------------

for n=1:len
	fileName = strcat(dirCSV, list(n).name);
	fid=fopen(fileName,'r');                                               %��ֻ����ʽ���ļ�                            
    
    for numHeaders=1:5   %�ļ�ͷ��5��
    line_str=fgetl(fid);
    eval([strcat('header',num2str(numHeaders)),'=line_str;']); %��ȡ�ļ�ͷ��Ϣ
    end
    line_str=fgetl(fid);  %���ݱ�ͷ
    numPoints=0;
    data=[];
    while feof(fid)==0
      numPoints=numPoints+1;
      data_str=fgetl(fid);
      a=str2num(data_str);
      data=cat(1,data,a);
    end
    data_Inormlinear(:,n) = data(:,6);  %����Ȥ��������csv�е�6��
    fclose(fid);   
end
zmm = data (:,2)';% ��������
disp('Mission Completed');
toc





















