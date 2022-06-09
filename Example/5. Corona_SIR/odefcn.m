function dydt = odefcn(t,y,beta,gamma)
dydt = zeros(3,1);
dydt(1) = (beta *y(3) - gamma) * y(1);
dydt(2) = gamma * y(1);
dydt(3) = -dydt(1) - dydt(2);
end
