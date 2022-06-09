function pi = pageRank(G)

    theta = 0.85; 
    epsilon = 0.001;

    n = numnodes(G);        % number of nodes
    A = adjacency(G);
    c = full(A);            % adjacency matrix, 
                            % c(i,j) == 1 if i and j are connnected

    % calculate out degree
    O = sum(c,2);
    
    %% compute H
    H = zeros(n,n);
    H = c ./ O;
    %% handle dangling nodes
    for i=1:n
        if O(i) == 0
            O(i) = n;
            H(i,1:n) = 1/n;
        end
    end
    %% add randomization (using theta)
    G_mat = H;
    G_mat = (theta .* H) + ((1-theta)/n .* ones(n,n));
    % initilize pi
    pi = 1/n * ones(1,n);
    
    %% run PageRank
    error = 1;
    while error > epsilon
        prev_pi = pi;
        pi = prev_pi * G_mat;

        % update error
        error = sum(abs(pi-prev_pi));
    end
end