function trajektoria434(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B)
   
    disp('Interpolacja wielomianami stopnia 4-3-4:')

% Zdefiniowanie czasu ruchu
    t0=0
    tk=10
    t1=1/3*tk
    t2=2/3*tk
    tr=t1-t0
    tb=t2-t1
    tw=tk-t2

    tx1=[t0:0.01:t1];
    tx2=[t1:0.01:t2];
    tx3=[t2:0.01:tk];
    
    tau1=(tx1./tr-t0/tr);
    tau2=1+(tx2./tb-t1/tb);
    tau3=2+(tx3./tw-t2/tw);

% Położenia
    q_A=[theta1_A theta2_A lambda3_A];
    q_B=[theta1_B theta2_B lambda3_B];


    % dla przyjętych q_1r i q_2w przyspieszenie w 2 fragmencie wielomianu
    % jest równe 0
    q_1r=1/4*(q_B+3*q_A);
    q_2w=1/4*(3*q_B+q_A);

    k=size(q_A);
    n=k(2);
    
    A=[1 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 1 1 1 1 1
    0 1/tr 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 1/tw 2/tw 3/tw 4/tw
    0 0 2/tr^2 0 0 0 0 0 0 0 0 0 0 0 
    0 0 0 0 0 0 0 0 0 0 0 2/tw^2 6/tw^2 12/tw^2
    1 1 1 1 1 0 0 0 0 0 0 0 0 0 
    0 0 0 0 0 1 1 1 1 0 0 0 0 0
    0 1/tr 2/tr 3/tr 4/tr 0 -1/tb 0 0 0 0 0 0 0
    0 0 0 0 0 0 1/tb 2/tb 3/tb 0 -1/tw 0 0 0
    0 0 2/tr^2 6/tr^2 12/tr^2 0 0 -2/tb^2 0 0 0 0 0 0
    0 0 0 0 0 0 0 2/tb^2 6/tb^2 0 0 -2/tw^2 0 0
    0 0 0 0 0 1 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 1 0 0 0 0];

% Nazwa okna wykresu i ustalenie rozmiaru
    figure('Name','Planowanie trajektorii interpolacją wielomianów 4-3-4','WindowState','maximized','NumberTitle','off')
  
    for i=1:n
    B=[q_A(i) q_B(i) 0 0 0 0 q_1r(i) q_2w(i) 0 0 0 0 q_1r(i) q_2w(i)]';
    X=inv(A)*B;
    a10=X(1);
    a11=X(2);
    a12=X(3);
    a13=X(4);
    a14=X(5);
    a20=X(6);
    a21=X(7);
    a22=X(8);
    a23=X(9);
    a30=X(10);
    a31=X(11);
    a32=X(12);
    a33=X(13);
    a34=X(14);

% Położenia 
    str1=num2str(i);
    str2='. para kinematyczna - położenie';

    q1_tau=a10+a11*tau1+a12*tau1.^2+a13*tau1.^3+a14*tau1.^4;

    q2_tau=a20+a21*(tau2-1)+a22*(tau2-1).^2+a23*(tau2-1).^3;

    q3_tau=a30+a31*(tau3-2)+a32*(tau3-2).^2+a33*(tau3-2).^3+a34*(tau3-2).^4;
    
    subplot(3,3,i)
    plot(tau1,q1_tau, tau2,q2_tau, tau3,q3_tau,'r') 
    hold on
    scatter(1,q2_tau(1),'filled')
    hold on
    scatter(2,q3_tau(2),'filled')
    legend('q_1','q_2','q_3','q(t1)','q(t2)')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau_1[0,1] \it\tau_2[1,2] \it\tau_3[2,3]')
    ylabel('q[m]')

% Prędkości 
    str2='. para kinematyczna - prędkość';

    dq1_tau=(a11+2*a12*tau1+3*a13*tau1.^2+4*a14*tau1.^3)/tr;

    dq2_tau=(a21+2*a22*(tau2-1)+3*a23*(tau2-1).^2)/tb;

    dq3_tau=(a31+2*a32*(tau3-2)+3*a33*(tau3-2).^2+4*a34*(tau3-2).^3)/tw;
    
    subplot(3,3,i+3)
    plot(tau1,dq1_tau,tau2, dq2_tau, tau3,dq3_tau,'r')
    hold on
    scatter(1,dq2_tau(1),'filled')
    hold on
    scatter(2,dq2_tau(2),'filled')
    legend('dq_1','dq_2','dq_3','dq(t1)','dq(t2)')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau_1[0,1] \it\tau_2[1,2] \it\tau_3[2,3]')
    ylabel('dq[m/s]')
    
% Przyspieszenia 
    str2='. para kinematyczna - przyspieszenie';
    
    ddq1_tau=(2*a12+6*a13*tau1+12*a14*tau1.^2)/tr^2;
    
    ddq2_tau=(2*a22+6*a23*(tau2-1))/tb^2;
    
    ddq3_tau=(2*a32+6*a33*(tau3-2)+12*a34*(tau3-2).^2)/tw^2;
    
    subplot(3,3,i+6)
    plot(tau1,ddq1_tau, tau2,ddq2_tau, tau3,ddq3_tau, 'r')
    hold on
    scatter(1,ddq2_tau(1),'filled')
    hold on
    scatter(2,ddq2_tau(2),'filled')
    legend('ddq_1','ddq_2','ddq_3','ddq(t1)','ddq(t2)')
    title(append(str1,str2));
    grid on
    xlabel('\it\tau_1[0,1] \it\tau_2[1,2] \it\tau_3[2,3]')
    ylabel('ddq[m/s^2]')
   
    end
end