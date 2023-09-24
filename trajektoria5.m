function trajektoria5(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B)

    disp('Planowanie trajektorią wielomian 5-go stopnia:')

% Zdefiniowanie czasu ruchu
    t0=0
    tk=10
    t=[t0:0.01:tk];
    tau=t./tk;

% Położenia    
    q_A=[theta1_A theta2_A lambda3_A];
    q_B=[theta1_B theta2_B lambda3_B];
    
    k=size(q_A);
    n=k(2);
    
    A=[1 0 0 0 0 0;
    1 1 1 1 1 1;
    0 1/tk 0 0 0 0;
    0 1/tk 2/tk 3/tk 4/tk 5/tk;
    0 0 2/tk^2 0 0 0;
    0 0 2/tk^2 6/tk^2 12/tk^2 20/tk^2];

% Nazwa okna wykresu i ustalenie rozmiaru
    figure('Name','Planowanie trajektorii wielomianem 5-go stopnia','WindowState','maximized','NumberTitle','off')

    for i=1:n
    B=[q_A(i) q_B(i) 0 0 0 0]';
    X=inv(A)*B;
    a0=X(1);
    a1=X(2);
    a2=X(3);
    a3=X(4);
    a4=X(5);
    a5=X(6);
    
% Położenia 
    str1=num2str(i);
    str2='. para kinematyczna - położenie';

    q_tau=a0+a1*tau+a2*tau.^2+a3*tau.^3+a4*tau.^4+a5*tau.^5;
    subplot(3,3,i)
    plot(tau,q_tau,'r')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('q[m]')
    
% Prędkości 
    str2='. para kinematyczna - prędkość';
    
    dq_tau=(a1+2*a2*tau+3*a3*tau.^2+4*a4*tau.^3+5*a5*tau.^4)/tk;
    subplot(3,3,i+3)
    plot(tau,dq_tau,'r')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('dq[m/s]')
    
% Przyspieszenia 
    str2='. para kinematyczna - przyspieszenie';

    ddq_tau=(2*a2+6*a3*tau+12*a4*tau.^2+20*a5*tau.^3)/tk^2;
    subplot(3,3,i+6)
    plot(tau,ddq_tau,'r')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau')
    ylabel('ddq[m/s^2]')

    end
end