L = 160 * membrane(1, 100);

f = figure("Color","w");
ax = axes;
s = surface(L, 'EdgeColor', 'none');
view(3)

ax.XLim = [1 201];
ax.YLim = [1 201];
ax.ZLim = [-53.4 160];
ax.CameraPosition = [-145.5 -229.7 283.6];
ax.CameraTarget = [77.4 60.2 63.9];
ax.CameraUpVector = [0 0 1];
ax.CameraViewAngle = 36.7;
ax.Position = [0 0 1 1];
ax.DataAspectRatio = [1 1 0.9];

l1 = light('Position', [50 75 150], 'Style', 'infinite', 'Color', "#00B3FF");
l2 = light('Position', [0 400 150], 'Style', 'local', 'Color', "#00B3FF");
l3 = light('Position', [0.5 -1 0.4], 'Color', [0.8 0.8 0]);

s.FaceColor = [0.9 0.2 0.2];
s.FaceLighting = 'gouraud';
s.AmbientStrength = 0.3;
s.DiffuseStrength = 0.6;
s.BackFaceLighting = 'lit';
s.SpecularStrength = 1;
s.SpecularColorReflectance = 1;
s.SpecularExponent = 7;

axis off;

exportgraphics(gca,"matlab_logo.jpg","Resolution",900)