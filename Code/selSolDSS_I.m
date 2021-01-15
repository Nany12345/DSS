function selVal = selSolDSS_I(objVal,selNum,runInd,distance)
            
    rng(runInd);
    numSet = size(objVal,1);
    selIndex = randperm(numSet,selNum);
    selIndex = sort(selIndex);
    allIndex = 1:numSet;
    selVal = objVal(selIndex,:);
    restIndex = allIndex;
    restIndex(selIndex) = [];
    
    % Maximum iteration number, which can be changed.
    maxIteration = 10000;
    currentIteration = 0;            
    %level = [];
    
    while currentIteration < maxIteration
        solIndex = randperm(numSet-selNum,1);
        sol = objVal(restIndex(solIndex),:);
        selIndex = [selIndex,restIndex(solIndex)];
        restIndex(solIndex) = [];                
        selVal = [selVal;sol];
        
        % Distance calculation, other distances can be used.
        if strcmp(distance,'IGD+')
            distanceMatrix = pdist2(selVal,selVal,@ModifiedDistance);
        elseif strcmp(distance,'IGD+2')
            distanceMatrix = pdist2(selVal,selVal,@ModifiedDistance2);
        elseif strcmp(distance,'Manhattan')
            distanceMatrix = pdist2(selVal,selVal,@Manhattan);
        elseif strcmp(distance,'Minkowski')
            distanceMatrix = pdist2(selVal,selVal,distance,0.5);
        else
            distanceMatrix = pdist2(selVal,selVal,distance);
        end
        distanceMatrix(logical(eye(size(distanceMatrix))))=inf(1,selNum+1);
        
        deltaS = min(distanceMatrix,[],2);
        [~,index] = sort(deltaS);
        
        vector1 = distanceMatrix(index(1),:);
        vector1(index(2)) = [];
        vector2 = distanceMatrix(index(2),:);
        vector2(index(1)) = [];
        
        deltaS1 = min(vector1);
        deltaS2 = min(vector2);
        if deltaS1 >= deltaS2
             selVal(index(2),:) = [];
             restIndex = [restIndex,selIndex(index(2))];
             selIndex(index(2)) = [];                     
             %level = [level,deltaS1];
         else
             selVal(index(1),:) = [];
             restIndex = [restIndex,selIndex(index(1))];
             selIndex(index(1)) = [];                    
             %level = [level,deltaS2];
        end                                
        currentIteration = currentIteration+1;                
    end        
end
function d = ModifiedDistance(z,a)
    [M,~] = size(a);
    d = min(sqrt(sum(max(a-repmat(z,M,1),0).^2,2)),sqrt(sum(max(repmat(z,M,1)-a,0).^2,2)));
end
function d = ModifiedDistance2(z,a)
    [M,~] = size(a);
    d = max(sqrt(sum(max(a-repmat(z,M,1),0).^2,2)),sqrt(sum(max(repmat(z,M,1)-a,0).^2,2)));
end
function d = Manhattan(z,a)
    d = sum(abs(z-a),2);
end
