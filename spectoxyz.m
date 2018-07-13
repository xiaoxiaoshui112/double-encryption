%==========================================================================
%�������ܣ�ѡ����Դ���׼�۲��ߣ������׷�����ת��ΪXYZ�̼�ֵ
%Reference:https://blog.csdn.net/lxw907304340/article/details/45641419
%==========================================================================
function XYZ=spectoxyz(rec,Source,formulary,M)
[lambda1, xFcn, yFcn, zFcn] = colorMatchFcn(formulary);
[lambda2, energy] = illuminant(Source);
F=[lambda1;xFcn;yFcn;zFcn];
F=F';
S=[lambda2,energy];
% rec��Source�����ķ�Χ�ͼ�����ܲ�һ���������ҳ����߹��еĲ���
[comn,~,~] = intersect(rec(:,1),S(:,1));
% SR��RSPD�Լ�CIE_Std�����ķ�Χ�ͼ�����ܲ�һ����S�����ҳ�3�߹��еĲ���
[~,ia,~] = intersect(F(:,1),comn);
[~,ib,~] = intersect(rec(:,1),comn);
[~,ic,~] = intersect(S(:,1),comn);
if S(ic,2)==0
    XYZ= [0 0 0];
    return
end   
K=M/sum(S(ic,2).*F(ia,3));% ����Kֵ
[~,sample_num]=size(rec);
XYZ=zeros(sample_num-1,3);
for ii=2:sample_num
    Xt=K*sum(S(ic,2).* F(ia,2).*rec(ib,ii)); % ����X�̼�ֵ
    Yt=K*sum(S(ic,2).* F(ia,3).*rec(ib,ii)); % ����Y�̼�ֵ
    Zt=K*sum(S(ic,2).* F(ia,4).*rec(ib,ii)); % ����Z�̼�ֵ
    XYZ(ii-1,:)=[Xt,Yt,Zt];
end

















