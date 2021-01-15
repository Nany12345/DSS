addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
PF = {'linear_triangular','linear_invertedtriangular','concave_triangular', ...
    'concave_invertedtriangular','convex_triangular','convex_invertedtriangular'};

%% run for Greedy Inclusion
% for objInd = 1:length(obj)
%     M = obj(objInd);
%     for proInd = 1:length(PF)
%         proType = PF{proInd};
%         inFileName = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
%         disp(['GI--',inFileName]);
%         data_set_in = load(inFileName);
%         data_set_in = data_set_in.data_set;
%         data_set_out = zeros(selNum,M,setNum);
%         parfor setInd = 1:setNum
%             data_set_out(:,:,setInd) = selSolDSS_GI(data_set_in(:,:,setInd),selNum);
%         end
%         data_set = data_set_out;
%         outFileName = sprintf('./DataSel/data_set_GI_%s_M%d.mat',proType,M);
%         save(outFileName,'data_set');
%     end
% end
% 
% %% run for Greedy Iteral
% for objInd = 1:length(obj)
%     M = obj(objInd);
%     for proInd = 1:length(PF)
%         proType = PF{proInd};
%         inFileName = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
%         disp(['I--',inFileName]);
%         data_set_in = load(inFileName);
%         data_set_in = data_set_in.data_set;
%         for runInd = 1:runNum
%             data_set_out = zeros(selNum,M,setNum);
%             parfor setInd = 1:setNum
%                 data_set_out(:,:,setInd) = selSolDSS_I(data_set_in(:,:,setInd), ...
%                     selNum,runInd,'Euclidean');
%             end
%             data_set = data_set_out;
%             outFileName = sprintf('./DataSel/data_set_I_%s_M%d_%d.mat', ...
%                 proType,M,runInd);
%             save(outFileName,'data_set');
%         end
%     end
% end

%% run for Greedy Removal
for objInd = 2
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        inFileName = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
        disp(['GR--',inFileName]);
        data_set_in = load(inFileName);
        data_set_in = data_set_in.data_set;
        data_set_out = zeros(selNum,M,setNum);
        parfor setInd = 1:setNum
            data_set_out(:,:,setInd) = selSolDSS_GR(data_set_in(:,:,setInd),selNum);
        end
        data_set = data_set_out;
        outFileName = sprintf('./DataSel/data_set_GR_%s_M%d.mat',proType,M);
        save(outFileName,'data_set');
    end
end
