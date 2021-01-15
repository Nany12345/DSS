addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
refSetInd = 1;
PF = {'linear_triangular','convex_triangular','concave_triangular', ...
    'linear_invertedtriangular','convex_invertedtriangular','concave_invertedtriangular'};
dist = {'Euclidean','Manhattan','Chebychev','Minkowski','Cosine','IGD+','IGD+2'};

HV = zeros(length(obj),length(dist),length(PF));
IGD = zeros(length(obj),length(dist),length(PF));
for proInd = 1:length(PF)
    proType = PF{proInd};
    for objInd = 1:length(obj)
        M = obj(objInd);
        for distInd = 1:length(dist)
            distance = dist{distInd};
            inFileNameHV  = sprintf('./Result/HV_I_%s_%s_M%d.mat',distance, ...
                proType,M);
            inFileNameIGD = sprintf('./Result/IGD_I_%s_%s_M%d.mat',distance, ...
                proType,M);
            HV_in = load(inFileNameHV);
            HV_in = HV_in.HV_val;
            IGD_in = load(inFileNameIGD);
            IGD_in = IGD_in.IGD_val;
            HV(objInd,distInd,proInd)  = mean(mean(HV_in,1),2);
            IGD(objInd,distInd,proInd) = mean(mean(IGD_in,1),2);
            HVSel = HV_in(:,1)';
            HVSort = sort(HVSel);
            runInd = find(HVSel==HVSort(runNum/2));
            disp([proType,'_M=',num2str(M),'_',distance,'_runInd=',num2str(runInd)]);
            inFileNameDataOri = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
            dataOri = load(inFileNameDataOri);
            dataOri = dataOri.data_set;
            dataOri = dataOri(:,:,1);
            inFileNameDataSel = sprintf('./DataSel/data_set_I-%s_%s_M%d_%d.mat', ...
            distance,proType,M,runInd);
            dataSel = load(inFileNameDataSel);
            dataSel = dataSel.data_set;
            dataSel = dataSel(:,:,1);
            if M==3&&distInd==length(dist)
                %% Plot Part
                file_name = strcat('./Figure/Figure4/M',num2str(M),'_',proType,'_',...
                    distance);        
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
save('./Result/HV.mat','HV');
save('./Result/IGD.mat','IGD');
