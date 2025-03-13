clc; clear; 

%Defining the antenna parameters [SECTION 1]
c=physconst('LightSpeed');
freq=1e9;
lambda = c/freq; %normalised wavelength
L= lambda/2; %for half wave dipole. L=lambda for full wave dipole
k= 2*pi / lambda; %the wave number
plotRes = 1000;
%below angles in radians
thetaEL = linspace(0,2*pi, plotRes); %elevation angle sweep from 0 to 180 degrees
thetaAZI = linspace(0, 2*pi, plotRes);%azimuthal angle sweep from 0 to 360 degrees
%below angles in degrees
thetaELd = rad2deg(thetaEL);
thetaAZId = rad2deg(thetaAZI);

%compute the radiation pattern using far field approximation [SECTION 2]
RadPat = abs(sin(thetaEL));
RadPat(isnan(RadPat)) = 0;
RadPat = RadPat ./ max(RadPat(:));

%Coordinate handling [SECTION 3]
[EL, AZI] = meshgrid(thetaEL, thetaAZI); %each point in space is (thetaEL, thetaAZI)
Xcoord = (RadPat) .* sin(EL) .* cos(AZI);
Ycoord = (RadPat) .* sin(EL) .* sin(AZI);
Zcoord = (RadPat) .* cos(EL);
disp(['Min PowerPat: ', num2str(min(RadPat(:)))]);
disp(['Max PowerPat: ', num2str(max(RadPat(:)))]);
disp(['Min Xcoord: ', num2str(min(Xcoord(:)))]);
disp(['Max Xcoord: ', num2str(max(Xcoord(:)))]);
disp(['Min Ycoord: ', num2str(min(Ycoord(:)))]);
disp(['Max Ycoord: ', num2str(max(Ycoord(:)))]);
disp(['Min Zcoord: ', num2str(min(Zcoord(:)))]);
disp(['Max Zcoord: ', num2str(max(Zcoord(:)))]);

%Pattern plot of radiation [SECTION 4]
figure;
surf(Xcoord,Ycoord,Zcoord, 'EdgeColor','none'); % surface plot with a smooth 3D surface
colormap(jet) %Using a colour gradient to indicate intensity
colorbar;
axis equal;
shading interp;
title("3D radiation pattern of the half wave dipole antenna");
xlabel("X axis"); ylabel("y axis"); zlabel("z axis");
view(3); grid on;
daspect([1 1 1])  % Equal axis scaling

%2D polar plot [SECTION 5]
figure;
polarplot(thetaEL, RadPat, 'r', 'LineWidth',4);
title("2D polar plot of the dipole antenna"); grid on;
ax = gca;
ax.ThetaZeroLocation = 'top';  % Place 0° at the top




