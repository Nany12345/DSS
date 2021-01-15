addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
PF = {'linear_triangular','linear_invertedtriangular','concave_triangular', ...
    'concave_invertedtriangular','convex_triangular','convex_invertedtriangular'};
dist = {'Euclidean','Manhattan','Chebychev','Minkowski','Cosine','IGD+','IGD+2'};

%% run for Greedy Iteral
for objInd = 1:length(obj)
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        inFileName = sprintf('./Data/data_set_%s_M%d.mat',proType,M);
        data_set_in = load(inFileName);
        data_set_in = data_set_in.data_set;
        for distInd = length(dist)
            distance = dist{distInd};
            for runInd = 1:runNum
                data_set_out = zeros(selNum,M,setNum);
                parfor setInd = 1:setNum
                    data_set_out(:,:,setInd) = selSolDSS_I(data_set_in(:,:, ...
                        setInd),selNum,runInd,distance);
                end
                data_set = data_set_out;
                outFileName = sprintf('./DataSel/data_set_I-%s_%s_M%d_%d.mat', ...
                    dist{distInd},proType,M,runInd);
                disp(outFileName);
                save(outFileName,'data_set');
            end
        end
    end
end
