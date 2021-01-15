addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
refSetInd = 1;
PF = {'linear_triangular','convex_triangular','concave_triangular', ...
    'linear_invertedtriangular','convex_invertedtriangular','concave_invertedtriangular'};
Method = {'GI','GR','I'};

UL = zeros(length(obj),length(Method),length(PF));
for proInd = 1:length(PF)
    for objInd = 1:length(obj)
        M = obj(objInd);
        for metInd = 1:length(Method)
            proType = PF{proInd};
            inFileNameUL = sprintf('./Result/UL_%s_%s_M%d.mat',Method{metInd}, ...
                proType,M);
            UL_in = load(inFileNameUL);
            UL_in = UL_in.UL;
            UL(objInd,metInd,proInd) = mean(mean(UL_in,1),2);
            if metInd==3
                ULSel = UL_in(:,1)';
                ULSort = sort(ULSel);
                runInd = find(ULSel==ULSort(runNum/2));
                inFileNameDataOri = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
                dataOri = load(inFileNameDataOri);
                dataOri = dataOri.data_set;
                dataOri = dataOri(:,:,1);
                inFileNameDataSel = sprintf('./DataSel/data_set_I_%s_M%d_%d.mat', ...
                proType,M,runInd);
                dataSel = load(inFileNameDataSel);
                dataSel = dataSel.data_set;
                dataSel = dataSel(:,:,1);
            else
                ULSel = UL_in;
                ULSort = sort(ULSel);
                setInd = find(ULSel==ULSort(setNum/2));
                inFileNameDataOri = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
                dataOri = load(inFileNameDataOri);
                dataOri = dataOri.data_set;
                dataOri = dataOri(:,:,setInd);
                inFileNameDataSel = sprintf('./DataSel/data_set_%s_%s_M%d.mat', ...
                Method{1,metInd},proType,M);
                dataSel = load(inFileNameDataSel);
                dataSel = dataSel.data_set;
                dataSel = dataSel(:,:,setInd);
            end
            if M==3
                %% Plot Part
                file_name = strcat('./Figure/Figure3/M',num2str(M),'_',proType,'_', ...
                    Method{metInd});        
                Fig = figure(...
                    'Units',           'pixels',...
                    'Name',            file_name,...
                    'NumberTitle',     'off',...
                    'IntegerHandle',   'off');
                AxesH = axes(...
                    'Parent',          Fig,...
                    'XGrid',           'on',...
                    'YGrid',           'on',...
                    'Visible',         'on',...
                    'FontSize',        30);
                hold on;
                p2 = scatter3(dataSel(:,1),dataSel(:,2),dataSel(:,3),50,'r','fill');
                p1 = scatter3(dataOri(:,1),dataOri(:,2),dataOri(:,3),2,'fill');
                p1.MarkerFaceColor = [0.53 0.53 0.53];
                view(135,45);
                saveas(Fig,[Fig.Name],'png');
                close all;
            end
        end
    end
end
save('./Result/UL.mat','UL');
