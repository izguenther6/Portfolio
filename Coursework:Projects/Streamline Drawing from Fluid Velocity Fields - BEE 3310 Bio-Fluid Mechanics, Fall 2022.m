%{
SUMMARY
- homework assignment from BEE 3310: Bio-Fluid Mechanics - Fall 2022
- used velocity field data from slow-motion video of visible air flow to 
  create streamline drawings via iterative use of differential equations
- drew multiple overlayed streamlines using quiver plots
- created pathlines in other scripts

POSSIBLE IMPROVEMENTS
- my commenting was really uninformative here
- lots of efficiency left on the table...I have a lot of repetitive inits
  and loops that could be cleaned up
%}

% STREAMLINES at frame 1 

xo1=1113;
yo1=384;
xSL1 = [xo1];
ySL1 = [yo1];

xo2 = 1185;
yo2 = 312;
xSL2 = [xo2];
ySL2 = [yo2];
ds=10;

for j = 1:100
    %streamline 1
    uj1=interp2(x{1}, y{1}, u_filtered{1}, xSL1(j), ySL1(j));
    vj1=interp2(x{1}, y{1}, v_filtered{1}, xSL1(j), ySL1(j));

    mag1= sqrt(uj1^2+vj1^2);

    xNew1 = xSL1(j) + (uj1/mag1)*ds;
    yNew1 = ySL1(j) + (vj1/mag1)*ds;

    xSL1(j+1) = xNew1;
    ySL1(j+1) = yNew1;

    %streamline 2
    uj2=interp2(x{1}, y{1}, u_filtered{1}, xSL2(j), ySL2(j));
    vj2=interp2(x{1}, y{1}, v_filtered{1}, xSL2(j), ySL2(j));

    mag2= sqrt(uj2^2+vj2^2);

    xNew2 = xSL2(j) + (uj2/mag2)*ds;
    yNew2 = ySL2(j) + (vj2/mag2)*ds;

    xSL2(j+1) = xNew2;
    ySL2(j+1) = yNew2;
end
%%

% flow rate lines

% line 1  setup
slope1 = (ySL1(10)-ySL2(5))/(xSL1(10)-xSL2(5));
xRun1 = round(xSL1(10)-xSL2(5));
yLine1 = [];
xLine1 = [];
uLine1 = [];
vLine1 = [];
flow1 = 0;

% line 2 setup
slope2 = (ySL1(50)-ySL2(45))/(xSL1(50)-xSL2(45));
xRun2 = round(xSL1(50)-xSL2(45));
yLine2 = [];
xLine2 = [];
uLine2 = [];
vLine2 = [];
flow2 = 0;

% line 3 setup
slope3 = (ySL1(30)-ySL2(40))/(xSL1(30)-xSL2(40));
xRun3 = round(xSL1(30)-xSL2(40));
yLine3 = [];
xLine3 = [];
uLine3 = [];
vLine3 = [];
flow3 = 0;

% find line 1 and velocity components
for xi = 0:abs(xRun1)
    yLine1(xi+1) = slope1*xi + ySL1(10);
    xLine1(xi+1) = xi + xSL1(10);

    uLine1(xi+1)=interp2(x{1}, y{1}, u_filtered{1}, xLine1(xi+1), yLine1(xi+1));
    vLine1(xi+1)=interp2(x{1}, y{1}, v_filtered{1}, xLine1(xi+1), yLine1(xi+1));

    flow1 = flow1 + sqrt(uLine1(xi+1)^2+vLine1(xi+1)^2);

end

% find line 2 and velocity components
for xi = 0:abs(xRun2)
    yLine2(xi+1) = slope2*xi + ySL1(50);
    xLine2(xi+1) = xi + xSL1(50);

    uLine2(xi+1)=interp2(x{1}, y{1}, u_filtered{1}, xLine2(xi+1), yLine2(xi+1));
    vLine2(xi+1)=interp2(x{1}, y{1}, v_filtered{1}, xLine2(xi+1), yLine2(xi+1));

    flow2 = flow2 + sqrt(uLine2(xi+1)^2+vLine2(xi+1)^2);
end

% find line 3 and velocity components
for xi = 0:abs(xRun3)
    yLine3(xi+1) = slope3*xi + ySL2(40);
    xLine3(xi+1) = xi + xSL2(40);

    uLine3(xi+1)=interp2(x{1}, y{1}, u_filtered{1}, xLine3(xi+1), yLine3(xi+1));
    vLine3(xi+1)=interp2(x{1}, y{1}, v_filtered{1}, xLine3(xi+1), yLine3(xi+1));

    flow3 = flow3 + sqrt(uLine3(xi+1)^2+vLine3(xi+1)^2);
end




figure
hold on
quiver(x{1},y{1},u_filtered{1},v_filtered{1});
plot(xSL1,ySL1);
plot(xSL2,ySL2);
plot(xLine1,yLine1);
plot(xLine2,yLine2);
plot(xLine3,yLine3);
title('Streamline for Frame 1');
legend('Velocity Field','Streamline 1','Streamline 2', ...
    ['Line 1: Q = ', num2str(flow1)],['Line 2: Q = ', num2str(flow2)], ...
    ['Line 3: Q = ', num2str(flow3)]);
xlabel('x');
ylabel('y');

