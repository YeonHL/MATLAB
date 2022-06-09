function dydt = odefun(t,y)
dydt = zeros(3,1);
dydt(1) = (y(3) - 0.1) * y(1);
dydt(2) = 0.1 * y(1);
dydt(3) = -dydt(1) - dydt(2);
end

%% SI model
% function dydt = odefun(t,y)
% dydt = zeros(2,1);
% dydt(1) = y(1)*y(2);
% dydt(2) = -dydt(1);
% end
%% SIR model