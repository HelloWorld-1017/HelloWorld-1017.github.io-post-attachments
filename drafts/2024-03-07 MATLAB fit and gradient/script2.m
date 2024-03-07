clc,clear,close all

% Vector of currents
current = 0:0.1:1.0; % A
% Vector of displacements
x = (0:0.05:0.2)*1e-3; % m
% Flux linkage, Phi(current,x)
flux_linkage = [0         0         0         0         0;
  8.4997e-003  7.9390e-003  7.4582e-003  7.0518e-003  6.7144e-003
  1.7097e-002  1.6045e-002  1.5133e-002  1.4349e-002  1.3683e-002
  2.5367e-002  2.3914e-002  2.2640e-002  2.1528e-002  2.0561e-002
  3.2966e-002  3.1222e-002  2.9675e-002  2.8304e-002  2.7086e-002
  3.9631e-002  3.7726e-002  3.6016e-002  3.4474e-002  3.3073e-002
  4.5179e-002  4.3263e-002  4.1519e-002  3.9916e-002  3.8420e-002
  4.9509e-002  4.7751e-002  4.6123e-002  4.4587e-002  4.3106e-002
  5.2600e-002  5.1190e-002  4.9847e-002  4.8527e-002  4.7188e-002
  5.4509e-002  5.3657e-002  5.2789e-002  5.1855e-002  5.0807e-002
  5.5379e-002  5.5314e-002  5.5130e-002  5.4770e-002  5.4181e-002];

% Use least squares to find a smooth differentiable function fit to flux.
[b,a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current
a=a(:); b=b(:); data_coeff = flux_linkage(:);
X = [a.^3 b.*a.^2 a.^2 a b a.*b];
Coeff = (X'*X)\(X'*data_coeff);
flux_linkage2 = reshape(X*Coeff,length(current),length(x));

% Calculate "dPhi(x,i)/dx" and "dPhi(x,i)/di"
zeros_like_b = zeros(length(b),1);
ones_like_b = ones(length(b),1);
dfluxdx = reshape([zeros_like_b,a.^2,zeros_like_b,zeros_like_b,ones_like_b,a]*Coeff,length(current),length(x));
dfluxdi = reshape([3.*a.^2,2.*b.*a,2.*a,ones_like_b,zeros_like_b,b]*Coeff,length(current),length(x));
dfluxdx(1,:) = zeros(1,5); % Set partial derivative to exactly zero for zero current, according to official example document.

% Fit flux linkage data by `fit` function
[X,CURRENT] = meshgrid(x,current);
flux_linkage_fit = fit([X(:),CURRENT(:)],flux_linkage(:),"poly23"); 
flux_linkage3 = reshape(flux_linkage_fit([X(:),CURRENT(:)]),numel(current),numel(x)); % ATTENTION the size parameter of `reshape` function
% Make partial derivatives
[dfluxdx2,dfluxdi2] = gradient(flux_linkage3,x(2)-x(1),current(2)-current(1));

f = figure("Color","w");
FontSize = 13;
f.Position(1:2) = [380,580];
f.Position(3) = 3*f.Position(3);
tiledlayout(1,3)
% Flux linkage
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"FontName","Times New Roman","FontSize",FontSize)
view(3)
% scatter3(X(:),CURRENT(:),flux_linkage(:),"filled","DisplayName","Data")
surf(x,current,flux_linkage, ...
    "FaceColor",[1,0,0],"DisplayName","Flux linkage data");
surf(x,current,flux_linkage2, ...
    'FaceColor',[0,0,1],"DisplayName","Polynomial fit");
surf(X,CURRENT,flux_linkage2, ...
    "FaceColor",[0,1,0],"DisplayName","Fit by `fit` function")
title("Flux Linkage vs. Current and Displacement")
xlabel("Displacement (m)")
ylabel("Current (A)")
zlabel("Flux linkage (Wb)")
axis([0,2e-4,0,1,0,0.06])
legend("Location","Best")

% Partial derivative of flux with respect to current
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"FontName","Times New Roman","FontSize",FontSize)
view(3)
surf(x,current,dfluxdi, ...
    "FaceColor",[1,0,0],"DisplayName","Partial derivative of polynomial function");
surf(x,current,dfluxdi2, ...
    "FaceColor",[0,1,0],"DisplayName","Numerical partial derivative by `gradient` function");
xlabel("Displacement (m)")
ylabel("Current (A)")
zlabel("\partial\Phi/\partiali (Wb/A)")
title("Partial Derivative of Flux with Respect to Current")
legend("Location","best");

% Partial derivative of flux with respect to distance
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
set(gca,"FontName","Times New Roman","FontSize",FontSize)
view(3)
surf(x,current,dfluxdx, ...
    "FaceColor",[1,0,0],"DisplayName","Partial derivative of polynomial function");
surf(x,current,dfluxdx2, ...
    "FaceColor",[0,1,0],"DisplayName","Numerical partial derivative by `gradient` function");
xlabel("Displacement (m)")
ylabel("Current (A)")
zlabel("\partial\Phi/\partialx (Wb/m)")
title("Partial Derivative of Flux with Respect to Distance")
axis([0,2e-4,0,1,-35,0])
legend("Location","best");
