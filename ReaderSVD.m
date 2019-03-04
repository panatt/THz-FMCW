%clear;
clc

%-----------------------------1.Pick a file -------------------------------
[filename, pathname] = uigetfile({ '*.svd','SVD-files(*.svd)'},'Please pick a *.svd file');

if ~(ischar(filename))                                                     %如果没有选取文件则中断程序的执行，          
    return                                                                 %end后的代码失效，
end                                                                        %提高程序效率。

%-----------------------------2.Read the file -----------------------------
%-----------（1）Read header ----------------------------------------------

disp('Loading File ...');
fid=fopen(filename,'r');                                                   %以只读形式打开文件
line_str='';                                
ii=0;

while ~(strcmp(line_str,'end_of_header'))
   ii=ii+1;
 line_str=fgetl(fid);
    if ~(strcmp(line_str,'end_of_header'))
        eval([strcat('header',num2str(ii)),'=line_str;']);
    end     
end
%-----------（2）Read data ------------------------------------------------
        %------------  Information -----------
name='';
while ~(strcmp(name,'end_of_var_list'))
     line_str=fgetl(fid);
    [name,value] = strread(line_str,'%s%f');                               %name返回的是元胞数组
    if ~(strcmp(name,'end_of_var_list'))
        eval([char(name) '=' num2str(value) ';']);
     end
   
end
        %---------------Main data -------------
NT=t_max-t_min;                                                                                                   
[data count]=fread(fid,inf,'*uint8');
fclose(fid);

%----------------------------3.Data pretreatment --------------------------
data=reshape(data,NT*NX,2,NY);     
data1=reshape(data(:,1,:),NT,NX,NY);
intensity=permute(data1,[2 3 1]);                                          %变换坐标到NX*NY*NT，将z轴作为层
intensity=permute(intensity,[2 1 3]);
data2=reshape(data(:,2,:),NT,NX,NY);
phase=permute(data2,[2 3 1]);
phase=permute(phase,[2 1 3]);

%----------------------------4.Clear useless variables --------------------------
% clear F_Start F_Stop F_Stop_meas NF ans count data data1 data2 dx dy fid filename filterindex ii line_str name pathname t_max t_min value x_max_match  x_max_short x_min x_min_match x_min_short y_min y_match y_short
disp('... Ready');