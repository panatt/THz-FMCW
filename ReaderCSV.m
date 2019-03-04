%%----本程序用于读取SynViewScan 300系统的*.csv文件数据
%%----王天一
%%----2015

clear all;
clc;
%------------------产生一个标准对话框来选择要打开的文件----------------------
[filename, pathname] = uigetfile({ '*.csv','CSV-files(*.csv)'},'Please pick a *.csv file');
if ~(ischar(filename))                                                     %如果cancel则中断程序的执行，end后的代码失效（提高程序稳定性）          
    clear filename pathname
    return
end
%------------------------ Get file infomation -----------------------------
tic
fid=fopen(filename,'r');                                                   %以只读形式打开文件
line_str='';                                
disp('Loading File ...');
for ii=1:5
   line_str=fgetl(fid);
  eval([strcat('header',num2str(ii)),'=line_str;']);
end

%---------------------------- Read data -----------------------------------
line_str=fgetl(fid);
jj=0;
A=[];
while feof(fid)==0
    jj=jj+1;
    data_str=fgetl(fid);
    a=str2num(data_str);
    A=cat(1,A,a);
end
fclose(fid);                                                               %成功返回0，失败返回-1

%---------------------Obtain coordinate X and Y----------------------------

n1=(regexp(header4,'-')>regexp(header4,':')).*regexp(header4,'-');
I=find(n1~=0);
b=header4(n1(I));
c=header4(regexp(header4,'\d'));
d=[b c];
X=str2num(d);

n1=(regexp(header5,'-')>regexp(header5,':')).*regexp(header5,'-');
I=find(n1~=0);
b=header5(n1(I));
c=header5(regexp(header5,'\d'));
d=[b c];
Y=str2num(d);

%----------------------------Data arrange----------------------------------
tps=A(:,1);
zmm=A(:,2);
Enorm=A(:,3);
absEnorm=A(:,4);
InormdB=A(:,5);
Inormlinear=A(:,6);

clear a A fid filterindex data_str filename ii jj line_str pathname ans b c d I n1

disp('... Ready');

toc