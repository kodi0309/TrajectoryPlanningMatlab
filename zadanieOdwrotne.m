function [zOdw_theta1, zOdw_theta2, zOdw_lambda3, zOdw_B30]=zadanieOdwrotne(rxnum,rynum,rznum)

% Stworzennie zmiennych symbolicznych manipulaotra RRP
    syms    theta1 lambda1 l1 alpha1 ... 
            theta2 lambda2 l2 alpha2 ...
            theta3 lambda3 l3 alpha3;    

% Zdefiniowanie stałych wymiarów manipulatora
    theta3=sym(0); 
    lambda1=sym(0);
    lambda2=sym(1);
    l1=sym(1);
    l2=sym(0);
    l3=sym(1);
    alpha1=sym(3*pi/2);
    alpha2=sym(3*pi/2);
    alpha3=sym(0);

% Wyświetlenie wymiarów manipulatora
    %disp('Dane manipulatora: ');
    theta=[theta1 theta2 theta3]; %theta [rad]
    lambda =[lambda1 lambda2 lambda3]; %lambda [m]
    l= [l1 l2 l3]; %l [m]   
    alpha= [alpha1 alpha2 alpha3]; %alpha[rad]

% Macierz przekształcenia jednorodnego
    k=size(theta);
    n=k(2);
    for i=1:n
        A=matrixA(theta(i),lambda(i),l(i),alpha(i));
        eval(['A' num2str(i) '=A;';]);
    end

% Macierz przejścia z układu 3 do 0
    %disp('Macierz przejścia T30: ');
    T30=A1*A2*A3;

% Wektor pozycji chwytaka względem podstawy
    %disp('Wektor pozycji p30: ');
    p30=T30(1:3,4);
    p30s=subs(p30);

% Stworzenie układu równań; dla każdej składowej
    rx=p30s(1);
    ry=p30s(2);
    rz=p30s(3);

% Przekształcenie układu równań
    row1=rx-rxnum;
    row2=ry-rynum;
    row3=rz-rznum;

% Rozwiązanie układu równań
    %disp('rozwiązanie: ');
    rozw=solve(row1==0,row2==0,row3==0);

% Rozdzielenie zmiennych
    theta1s=rozw.theta1;
    theta2s=rozw.theta2;
    lambda3s=rozw.lambda3;

% Przypisane odpowiednich rozwiązań
    zOdw_theta1=double(theta1s);
    zOdw_theta2=double(theta2s);
    zOdw_lambda3=double(lambda3s);

% Sprawdzanie macierzy
    odwrB30=T30(1:3,1:3);
    B30r=subs(odwrB30,[theta1,theta2],[zOdw_theta1,zOdw_theta2]);
    zOdw_B30=eval(B30r);

