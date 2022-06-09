clear;
close all;

% Example
s = [1 1 1 2 2 3 3 3 4];
t = [2 3 4 3 4 1 4 5 5];
weights = [8 6 4 -3 9 -2 -5 6 7];
G = digraph(s,t,weights);
plot(G,'EdgeLabel',G.Edges.Weight)

n = numnodes(G);
A = adjacency(G, 'weighted');
c = full(A);
for i=1:n
    for j=1:n
        if i~=j && c(i,j) == 0 
            c(i,j) = Inf;
        end
    end
end

p = bellmanFordRouting(c,5)