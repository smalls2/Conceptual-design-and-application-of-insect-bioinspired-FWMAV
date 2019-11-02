syms E v E1 E2 v12 v21 G12  z1 z2 z3 z0 tc E3 L W d31 d32 y p1 p2;
E=6.2e10;v=0.34;E3=200;
p1=7800;p2=1500;d31=-320e-12;d32=-320e-12;
E1=350e9;E2=7e9;v12=0.33;G12=5e9;
v21=E2*v12/E1;
y=pi/4;
L=10e-3;W=2e-3;
Q11=E1/(1-v12*v21);Q12=v12*E2/(1-v12*v21);Q22=E2/(1-v12*v21);Q66=G12;

Q111=Q11*(cos(-y))^4+2*(Q12+2*Q66)*(sin(-y))^2*(cos(-y))^2+Q22*(sin(-y))^4;
Q121=(Q11+Q12-4*Q66)*(sin(-y))^2*(cos(-y))^2+Q12*(cos(-y)^4+sin(-y)^4);
Q161=(Q11-Q12-2*Q66)*(sin(-y))*(cos(-y))^3+(Q12-Q22+2*Q66)*(sin(-y))^3*(cos(-y));
Q221=Q11*(sin(-y))^4+2*(Q12+2*Q66)*(sin(-y))^2*(cos(-y))^2+Q22*(cos(-y))^4;
Q261=(Q11-Q12-2*Q66)*(sin(-y))^3*(cos(-y))+(Q12-Q22+2*Q66)*(sin(-y))*(cos(-y))^3;
Q661=(Q11+Q22-2*Q12-2*Q66)*sin(-y)^2*cos(-y)^2+Q66*(cos(-y)^4+sin(-y)^4);
Q112=E/(1-v^2);
Q122=E*v/(1-v^2);
Q162=0;
Q222=E/(1-v^2);
Q262=0;
Q662=E/2/(1+v);
Q113=Q11*(cos(y))^4+2*(Q12+2*Q66)*(sin(y))^2*(cos(y))^2+Q22*(sin(y))^4;
Q123=(Q11+Q12-4*Q66)*(sin(y))^2*(cos(y))^2+Q12*(cos(y)^4+sin(y)^4);
Q163=(Q11-Q12-2*Q66)*(sin(y))*(cos(y))^3+(Q12-Q22+2*Q66)*(sin(y))^3*(cos(y));
Q223=Q11*(sin(y))^4+2*(Q12+2*Q66)*(sin(y))^2*(cos(y))^2+Q22*(cos(y))^4;
Q263=(Q11-Q12-2*Q66)*(sin(y))^3*(cos(y))+(Q12-Q22+2*Q66)*(sin(y))*(cos(y))^3;
Q663=(Q11+Q22-2*Q12-2*Q66)*sin(y)^2*cos(y)^2+Q66*(cos(y)^4+sin(y)^4);
i=1;
for tc=0:1:200;
    z0=-(tc+63.5)*1e-6;z1=-63.5e-6;z2=63.5e-6;z3=(tc+63.5)*1e-6;
A11=Q111*(z1-z0)+Q112*(z2-z1)+Q113*(z3-z2);
A12=Q121*(z1-z0)+Q122*(z2-z1)+Q123*(z3-z2);
A16=Q161*(z1-z0)+Q162*(z2-z1)+Q163*(z3-z2);
A22=Q221*(z1-z0)+Q222*(z2-z1)+Q223*(z3-z2);
A26=Q261*(z1-z0)+Q262*(z2-z1)+Q263*(z3-z2);
A66=Q661*(z1-z0)+Q662*(z2-z1)+Q663*(z3-z2);
B11=1/2*(Q111*(z1^2-z0^2)+Q112*(z2^2-z1^2)+Q113*(z3^2-z2^2));
B12=1/2*(Q121*(z1^2-z0^2)+Q122*(z2^2-z1^2)+Q123*(z3^2-z2^2));
B16=1/2*(Q161*(z1^2-z0^2)+Q162*(z2^2-z1^2)+Q163*(z3^2-z2^2));
B22=1/2*(Q221*(z1^2-z0^2)+Q222*(z2^2-z1^2)+Q223*(z3^2-z2^2));
B26=1/2*(Q261*(z1^2-z0^2)+Q262*(z2^2-z1^2)+Q263*(z3^2-z2^2));
B66=1/2*(Q661*(z1^2-z0^2)+Q662*(z2^2-z1^2)+Q663*(z3^2-z2^2));
D11=1/3*(Q111*(z1^3-z0^3)+Q112*(z2^3-z1^3)+Q113*(z3^3-z2^3));
D12=1/3*(Q121*(z1^3-z0^2)+Q122*(z2^3-z1^3)+Q123*(z3^3-z2^3));
D16=1/3*(Q161*(z1^3-z0^3)+Q162*(z2^3-z1^3)+Q163*(z3^3-z2^3));
D22=1/3*(Q221*(z1^3-z0^3)+Q222*(z2^3-z1^3)+Q223*(z3^3-z2^3));
D26=1/3*(Q261*(z1^3-z0^3)+Q262*(z2^3-z1^3)+Q263*(z3^3-z2^3));
D66=1/3*(Q661*(z1^3-z0^3)+Q662*(z2^3-z1^3)+Q663*(z3^3-z2^3));
F=[A11,A12,A16,B11,B12,B16;
    A12,A22,A26,B12,B22,B26;
    A16,A26,A66,B16,B26,B66;
    B11,B12,B16,D11,D12,D16;
    B12,B22,B26,D12,D22,D26;
    B16,B26,B66,D16,D26,D66];
C=inv(F);
Nx=E3*(z2-z1)*(Q112*d31+Q122*d32);
Ny=E3*(z2-z1)*(Q122*d31+Q222*d32);
Nxy=E3*(z2-z1)*(Q162*d31+Q262*d32);
kxy=C(6,1)*Nx+C(6,2)*Ny+C(6,3)*Nxy;
Q=atan(kxy*L);
M(i)=Q/180*pi;
T(i)=W*(C(6,1)*Nx+C(6,2)*Ny+C(6,3)*Nxy)./C(6,6);
m=L*W*(p1*(z1-z0+z3-z2)+p2*(z2-z1));
U(i)=Q*T(i)/m/2;
i=i+1;
end
 tc=0:1:200;
figure(1);
plot(tc,M)
xlabel('CF thickness(um)');
ylabel('output teist (deg)');
hold on
figure(2);
plot(tc,T)
xlabel('CF thickness(um)');
ylabel('Torque (Nm)');
hold on
figure(3);
plot(tc,U)
xlabel('CF thickness(um)');
ylabel('Energy Density (J/kg)');
hold on

