addpath(genpath(pwd));
load('./Result/HV.mat');
load('./Result/IGD.mat');
load('./Result/UL.mat');
numDist = 7;
numObj = 3;
numPro = 6;
numMethod = 3;
%% generate Tex file for HV/IGD
HVPrecision = '%.4f';%for very small value, use '%.1d'
Str_HV_IGD = cell(numObj*numPro,1);
fid = fopen('./Result/HV_IGD.txt','wt');
for j = 1:numPro
    for i = 1:numObj
        Str_HV_IGD{(j-1)*numObj+i,1} = '';
        HV_max = max(HV(i,:,j));
        HVInd = find(HV(i,:,j)==HV_max);
        IGD_min = min(IGD(i,:,j));
        IGDInd = find(IGD(i,:,j)==IGD_min);
        for k = 1:numDist
            if ismember(k,HVInd) && ismember(k,IGDInd)
                Str_HV_IGD{(j-1)*numObj+i,1} = [Str_HV_IGD{(j-1)*3+i,1}, ...
                    '&\textbf{',num2str(HV(i,k,j),HVPrecision),'}/\textbf{', ...
                    num2str(IGD(i,k,j),'%.4f'),'}'];
            elseif ~ismember(k,HVInd) && ismember(k,IGDInd)
                Str_HV_IGD{(j-1)*numObj+i,1} = [Str_HV_IGD{(j-1)*3+i,1}, ...
                    '&',num2str(HV(i,k,j),HVPrecision),'/\textbf{', ...
                    num2str(IGD(i,k,j),'%.4f'),'}'];
            elseif ismember(k,HVInd) && ~ismember(k,IGDInd)
                Str_HV_IGD{(j-1)*numObj+i,1} = [Str_HV_IGD{(j-1)*3+i,1}, ...
                    '&\textbf{',num2str(HV(i,k,j),HVPrecision),'}/', ...
                    num2str(IGD(i,k,j),'%.4f')];
            elseif ~ismember(k,HVInd) && ~ismember(k,IGDInd)
                Str_HV_IGD{(j-1)*numObj+i,1} = [Str_HV_IGD{(j-1)*3+i,1}, ...
                    '&',num2str(HV(i,k,j),HVPrecision),'/', ...
                    num2str(IGD(i,k,j),'%.4f')];
            end
        end
        fprintf(fid,'%s\n',Str_HV_IGD{(j-1)*numObj+i,1});
    end
end
fclose(fid);

%% generate Tex file for UL
Str_UL = cell(numObj*numPro,1);
fid = fopen('./Result/UL.txt','wt');
for j = 1:numPro
    for i = 1:numObj
        Str_UL{(j-1)*numObj+i,1} = '';
        for k = 1:numMethod
            if k==numMethod
                Str_UL{(j-1)*numObj+i,1} = [Str_UL{(j-1)*numObj+i,1}, ...
                    '&\textbf{',num2str(UL(i,k,j),'%.4f'),'}'];
            else
                Str_UL{(j-1)*numObj+i,1} = [Str_UL{(j-1)*numObj+i,1}, ...
                    '&',num2str(UL(i,k,j),'%.4f')];
            end
        end
        fprintf(fid,'%s\n',Str_UL{(j-1)*numObj+i,1});
    end
end
fclose(fid);
