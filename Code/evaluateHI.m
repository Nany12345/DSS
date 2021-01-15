addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
refSetInd = 1;
PF = {'linear_triangular','convex_triangular','concave_triangular', ...
    'linear_invertedtriangular','convex_invertedtriangular','concave_invertedtriangular'};
dist = {'Euclidean','Manhattan','Chebychev','Minkowski','Cosine','IGD+','IGD+2'};

%% run for Greedy Iteral
for objInd = 1:length(obj)
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        RefFile = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
        RefStruct = load(RefFile);
        RefPoints = RefStruct.data_set;
        RefPoints = RefPoints(:,:,refSetInd);
        for distInd = 7
            distance = dist{distInd};
            HV_val  = zeros(runNum,setNum);
            IGD_val = zeros(runNum,setNum);
            for runInd = 1:runNum
                inFileName = sprintf('./DataSel/data_set_I-%s_%s_M%d_%d.mat', ...
                    distance,proType,M,runInd);
                data_set_in = load(inFileName);
                data_set_in = data_set_in.data_set;
                parfor setInd = 1:setNum
                    HV_val(runInd,setInd)  = HV(data_set_in(:,:,setInd));
                    IGD_val(runInd,setInd) = IGD(data_set_in(:,:,setInd),RefPoints);
                end
            end
            outFileNameHV  = sprintf('./Result/HV_I_%s_%s_M%d.mat',distance, ...
                proType,M);
            outFileNameIGD = sprintf('./Result/IGD_I_%s_%s_M%d.mat',distance, ...
                proType,M);
            disp(outFileNameHV);
            save(outFileNameHV,'HV_val');
            save(outFileNameIGD,'IGD_val');
        end
    end
end
