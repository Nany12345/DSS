function selVal = selSolDSS_GR(objVal,selNum)
            % Distance calculation, other distances can be used.
            distance = pdist2(objVal,objVal);
            distance(logical(eye(size(distance))))=inf(1,length(objVal));
            %level = [];

            while size(objVal,1) > selNum
                deltaS = min(distance,[],2);
                [~,index] = sort(deltaS);
                
                vector1 = distance(index(1),:);
                vector1(index(2)) = [];
                vector2 = distance(index(2),:);
                vector2(index(1)) = [];
                
                deltaS1 = min(vector1);
                deltaS2 = min(vector2);
                if deltaS1 >= deltaS2
                     objVal(index(2),:) = [];
                     distance(index(2),:) = [];
                     distance(:,index(2)) = [];
                     %level = [level,deltaS1];
                else
                     objVal(index(1),:) = [];
                     distance(index(1),:) = [];
                     distance(:,index(1)) = [];
                     %level = [level,deltaS2];
                end       
            end    
            selVal = objVal;
end