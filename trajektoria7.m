function trajektoria7(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B)

    disp('Planowanie trajektorią wielomian 7-go stopnia:')

% Zdefiniowanie czasu ruchu
    t0=0
    tk=10
    tR=3
    tW=7
    t=[t0:0.01:tk];
    tau=t./tk;

% Położenia    
    q_A=[theta1_A theta2_A lambda3_A];
    q_B=[theta1_B theta2_B lambda3_B];
    
    k=size(q_A);
    n=k(2);

% Dodatkowe punkty pośrednie
    %disp('Punkt R')
    x_R = input('Zdefiniuj x [m]: '); %0.6
    y_R = input('Zdefiniuj y [m]: '); %2
    z_R = input('Zdefiniuj z [m]: '); %1.2
    
    %disp('Punkt W')
    x_W = input('Zdefiniuj x [m]: '); %0.8
    y_W = input('Zdefiniuj y [m]: '); %0.5
    z_W = input('Zdefiniuj z [m]: '); %0.2
    
%     %disp('Punkt R')
%     x_R = 0.6;
%     y_R = 2;
%     z_R = 1.2;
%     
%     %disp('Punkt W')
%     x_W = 0.8;
%     y_W = 0.5;
%     z_W = 0.2;

% Zadanie odwrotne kinematyki dla punktów R i W
    [theta1_R,theta2_R,lambda3_R]=zadanieOdwrotne(x_R,y_R,z_R);
    [theta1_W,theta2_W,lambda3_W]=zadanieOdwrotne(x_W,y_W,z_W);

    q_R=[theta1_R,theta2_R,lambda3_R];
    q_W=[theta1_W,theta2_W,lambda3_W]; 


    A=[1 0 0 0 0 0 0 0;
    1 1 1 1 1 1 1 1;
    0 1/tk 0 0 0 0 0 0;
    0 1/tk 2/tk 3/tk 4/tk 5/tk 6/tk 7/tk;
    0 0 2/tk^2 0 0 0 0 0;
    0 0 2/tk^2 6/tk^2 12/tk^2 20/tk^2 30/tk^2 42/tk^2;
    1 tR/tk (tR/tk)^2 (tR/tk)^3 (tR/tk)^4 (tR/tk)^5 (tR/tk)^6 (tR/tk)^7;
    1 tW/tk (tW/tk)^2 (tW/tk)^3 (tW/tk)^4 (tW/tk)^5 (tW/tk)^6 (tW/tk)^7];

% Nazwa okna wykresu i ustalenie rozmiaru
    figure('Name','Planowanie trajektorii wielomianem 7-go stopnia','WindowState','maximized','NumberTitle','off')

    for i=1:n
    B=[q_A(i) q_B(i) 0 0 0 0 q_R(i) q_W(i)]';
    X=inv(A)*B;
    a0=X(1);
    a1=X(2);
    a2=X(3);
    a3=X(4);
    a4=X(5);
    a5=X(6);
    a6=X(7);
    a7=X(8);
    
% Położenia 
    str1=num2str(i);
    str2='. para kinematyczna - położenie';

    q_tau=a0+a1.*tau+a2.*tau.^2+a3*tau.^3+a4.*tau.^4+a5.*tau.^5+a6.*tau.^6+a7.*tau.^7;
    subplot(3,3,i)
    plot(tau,q_tau,'r')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('q[m]')
    
% Prędkości 
    str2='. para kinematyczna - prędkość';
    
    dq_tau=(a1+2.*a2.*tau+3.*a3.*tau.^2+4.*a4.*tau.^3+5.*a5.*tau.^4+6.*a6.*tau.^5+7.*a7.*tau.^6)/tk;
    subplot(3,3,i+3)
    plot(tau,dq_tau,'r')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('dq[m/s]')
    
% Przyspieszenia 
    str2='. para kinematyczna - przyspieszenie';

    ddq_tau=(2.*a2.*tau+6.*a3.*tau.^1+12.*a4.*tau.^2+20.*a5.*tau.^3+30.*a6.*tau.^4+42.*a7.*tau.^5)/tk^2;
    subplot(3,3,i+6)
    plot(tau,ddq_tau,'r') 
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('ddq[m/s^2]')

    end
end