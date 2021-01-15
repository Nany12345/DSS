addpath(genpath(pwd));
for d = [3,5,10]
    solution_num = 10000;
    set_num = 30;
    for problem_type = [string('linear_triangular'),string('linear_invertedtriangular'), ...
            string('concave_triangular'),string('concave_invertedtriangular'), ...
            string('convex_triangular'),string('convex_invertedtriangular')]
        generateData_f(d, solution_num, problem_type, set_num);
    end
end

function data_set = generateData_f(dimension, solution_number, problem_type, set_number)
    % Generate data_set
    % problem_type = linear, concave, convex

    data_set = zeros(solution_number, dimension, set_number);
    for i = 1:set_number
        data_set(:, :, i) = generate_data(dimension, solution_number, problem_type,i);
    end
    data_set_file_name = sprintf('./Data/data_set_%s_M%d.mat',problem_type,dimension);
    save(data_set_file_name, 'data_set');

    function data = generate_data(dimension, solution_number, problem_type,set_ind)
        % Generate data
        % problem_type = linear, concave, convex

        %dimension
        dim = dimension;

        %number of solutions in a solution set
        solutionNum = solution_number;

        %raw data
        rng(set_ind);
        sigma = 0.6;
        data = zeros(solutionNum*dim,dim);
        %V = abs(R./sqrt(sum(R.^2,2)));
        %data = rand(solutionNum,dim);

        switch(problem_type)
            case string('linear_triangular')
                for obj_ind = 1:dim-1
                    obj_max = 1-sum(data(1:solutionNum,1:obj_ind-1),2);
                    data(1:solutionNum,obj_ind) = mod(abs(normrnd(0,sigma,solutionNum,1)),obj_max);
                end
                data(1:solutionNum,dim) = 1-sum(data(1:solutionNum,1:dim-1),2);
                datat=data(1:solutionNum,:);
                for obj_ind=1:dim
                    data((obj_ind-1)*solutionNum+1:obj_ind*solutionNum,:) = datat;
                    datat = circshift(datat,[0,1]);
                end
                valid = randperm(dim*solutionNum);
                valid = valid(1:solutionNum);
                data = data(valid,:);
            case string('linear_invertedtriangular')
                data = generate_data(dimension, solution_number,'linear_triangular',set_ind);
                data = data*(-1);
                data = data+1;
            case string('concave_triangular')
                for obj_ind = 1:dim-1
                    obj_max = sqrt(1-sum(data(1:solutionNum,1:obj_ind-1).^2,2));
                    data(1:solutionNum,obj_ind) = mod(abs(normrnd(0,sigma,solutionNum,1)),obj_max);
                end
                data(1:solutionNum,dim) = sqrt(1-sum(data(1:solutionNum,1:dim-1).^2,2));
                datat=data(1:solutionNum,:);
                for obj_ind=1:dim
                    data((obj_ind-1)*solutionNum+1:obj_ind*solutionNum,:) = datat;
                    datat = circshift(datat,[0,1]);
                end
                valid = randperm(dim*solutionNum);
                valid = valid(1:solutionNum);
                data = data(valid,:);
            case string('convex_invertedtriangular')
                data = generate_data(dimension, solution_number,'concave_triangular',set_ind);
                data = data*(-1);
                data = data+1;
            case string('convex_triangular')
                for obj_ind = 1:dim-1
                    obj_max = (1-sum(sqrt(data(1:solutionNum,1:obj_ind-1)),2)).^2;
                    data(1:solutionNum,obj_ind) = mod(abs(normrnd(0,sigma,solutionNum,1)),obj_max);
                end
                data(1:solutionNum,dim) = (1-sum(sqrt(data(1:solutionNum,1:dim-1)),2)).^2;
                datat=data(1:solutionNum,:);
                for obj_ind=1:dim
                    data((obj_ind-1)*solutionNum+1:obj_ind*solutionNum,:) = datat;
                    datat = circshift(datat,[0,1]);
                end
                valid = randperm(dim*solutionNum);
                valid = valid(1:solutionNum);
                data = data(valid,:);
            case string('concave_invertedtriangular')
                data = generate_data(dimension, solution_number,'convex_triangular',set_ind);
                data = data*(-1);
                data = data+1;
            otherwise
                fprintf('Invalid problem_type');
                data = [];
        end

    end

end
