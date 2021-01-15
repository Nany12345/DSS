addpath(genpath(pwd));
selNum = 100;
obj = [3,5,10];
setNum = 30;
runNum = 10;
PF = {'linear_triangular','linear_invertedtriangular','concave_triangular', ...
    'concave_invertedtriangular','convex_triangular','convex_invertedtriangular'};

%% run for Greedy Inclusion
for objInd = 1:length(obj)
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        inFileName = sprintf('./DataSel/data_set_GI_%s_M%d.mat',proType,M);
        disp(['GI--',inFileName]);
        data_set_in = load(inFileName);
        data_set_in = data_set_in.data_set;
        UL = zeros(1,setNum);
        parfor setInd = 1:setNum
            UL(1,setInd) = uniformLevel(data_set_in(:,:,setInd));
        end
        outFileName = sprintf('./Result/UL_GI_%s_M%d.mat',proType,M);
        save(outFileName,'UL');
    end
end

%% run for Greedy Iteral
for objInd = 1:length(obj)
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        UL = zeros(runNum,setNum);
        for runInd = 1:runNum
            inFileName = sprintf('./DataSel/data_set_I_%s_M%d_%d.mat', ...
                proType,M,runInd);
            disp(['GI--',inFileName]);
            data_set_in = load(inFileName);
            data_set_in = data_set_in.data_set;
            parfor setInd = 1:setNum
                UL(runInd,setInd) = uniformLevel(data_set_in(:,:,setInd));
            end
        end
        outFileName = sprintf('./Result/UL_I_%s_M%d.mat',proType,M);
        save(outFileName,'UL');
    end
end

%% run for Greedy Inclusion
for objInd = 1:length(obj)
    M = obj(objInd);
    for proInd = 1:length(PF)
        proType = PF{proInd};
        inFileName = sprintf('./DataSel/data_set_GR_%s_M%d.mat',proType,M);
        disp(['GR--',inFileName]);
        data_set_in = load(inFileName);
        data_set_in = data_set_in.data_set;
        UL = zeros(1,setNum);
        parfor setInd = 1:setNum
            UL(1,setInd) = uniformLevel(data_set_in(:,:,setInd));
        end
        outFileName = sprintf('./Result/UL_GR_%s_M%d.mat',proType,M);
        save(outFileName,'UL');
    end
end
