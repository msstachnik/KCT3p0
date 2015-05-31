function Y = differenction(X, T)
% funkcja licz¹ca pochodn¹ z wektora wartosci i czasu
T = [T(1) T T(end)];
X = [X(1) X X(end)];
dx = X(3:end) - X(1:end-2);
dt = T(3:end) - T(1:end-2);
Y = dx./dt;