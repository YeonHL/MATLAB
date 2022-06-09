% Don't use the "centrality" function or any MATLAB implemented function for pagerank

clear;
close all;

theta = 0.85;
epsilon = 0.001;     % convergence condition for the distance between pis

% Example

% Figure 3.2
s = [1 2 2 2 3 3 3];
t = [4 1 3 4 1 2 4];

% Figure 3.4
%s = [1 1 2 2 3 3 4 5 5 6 6 7 7 8 8 8];
%t = [2 3 1 5 2 8 3 4 8 5 4 6 4 1 4 7];

G = digraph(s,t);
plot(G)

pi = pageRank(G)


