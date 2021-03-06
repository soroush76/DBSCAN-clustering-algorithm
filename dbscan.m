function dataset = dbscan(dataset, epsilon, minPoints)
	%	first load dataset:
	% 	1- csvfile = textscan (fopen('dataset2'), '%s%f%f', 'delimiter', ',');
	%	2- dataset = [csvfile{2} csvfile{3}];
	%	3- ds = dbscan(dataset, ..., ...);
	
	dataset = unique(dataset, 'rows'); % usique dataset input matrix w.r.t rows
	dataset = [dataset zeros(size(dataset, 1), 1)]; % add a column of 1s to first column of the dataset

	clusterID = 1;
	for i=1:size(dataset, 1)
		point = dataset(i, :);
		if point(3) == 0
			[flag, dataset] = expandCluster(dataset, point, clusterID, epsilon, minPoints);
			if flag
				clusterID += 1;
			end
		end
	end

	colors_list = ['r', 'b', 'm', 'y', 'c', 'g']';
	shapes_list = ['*', '+', 'o', 'x']';

	% plot dataset and the result of clustering
	clf;
	hold on;
	plot(dataset(dataset(:, 3)==0, 1), dataset(dataset(:, 3)==0, 2), 'k*', 'MarkerSize', 5)
	idx = 1;
	flag = false;
	for s=1:size(shapes_list, 1)
		for c=1:size(colors_list, 1)
			plot(dataset(dataset(:, 3)==idx, 1), dataset(dataset(:, 3)==idx, 2),sprintf('%s',colors_list(c, :),shapes_list(s, :)),'MarkerSize',5)
			idx += 1;
			if idx >= clusterID
				flag = true;
				break
			end
		end
		if flag
			break
		end
	end

endfunction
