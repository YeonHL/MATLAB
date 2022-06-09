function [p] = bellmanFordRouting(c,d)
    %c(x,y): link cost from node x to y;  = Inf if not direct neighbors
    %d: node index of the destination d
    %p(v): current value of cost of path from source v to destination d.
    %prev_p(v): previous value of cost of path from source v to destination d.
    %n: number of nodes
    %num_neighbors(v): number of neighboring nodes of v including itself
    %neighbors(v,1:num_neighbors): array of neighboring nodes of
    
    % A. Calculate the number of nodes from the cost matrix c
    n = size(c,1);

    % A-2. Find the neighboring nodes for each node
    neighbors = zeros(n,n);
    num_neighbors = zeros(1,n);

    for v=1:n
        for w=1:n
            if w ~= v
                if c(v,w) ~= Inf
                    num_neighbors(v) = num_neighbors(v) + 1;
                    neighbors(v,num_neighbors(v)) = w;
                end
            end
        end
    end
    neighbors

    % B. Initialize p
    p = Inf(1,n);
    p(d) = 0;
    prev_p = p;
    
    % C. Loop
    for iteration=1:n
        for v=1:n-1
            p(v) = min(c(v,neighbors(v,1:num_neighbors(v))) + prev_p(neighbors(v,1:num_neighbors(v))));
            %for k=1:num_neighbors(v)
            %    p(v) = min(p(v), c(v,neighbors(v,k))+prev_p(neighbors(v,k)))
            %end
        end
        iteration
        prev_p = p
    end
    
    % D. Print p
    p