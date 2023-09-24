clc
clear 
close all

disp('Projekt 1 - Planowanie trajektorii manipulatorów o strukturze szeregowej')
disp('Manipulator RRP, kąty obrotu wokół stałego układu odniesienia YXZ')
disp('Projekt zrealizowany przez: Klaudiusz Kozłowski, Mariusz Kot 13A6 P04')
disp(' ')
disp('>> Wciśnij ENTER!')
pause
disp(' ')
disp(' ')



% Wprowadzenie danych planowania trajektorii
    disp('Punkt A - start')
    x_A = input('Podaj x [m]: '); % -0.7717 
    y_A = input('Podaj y [m]: '); % 0.6490
    z_A = input('Podaj z [m]: '); % -0.7012
    alpha_A = input('Podaj alpha [rad]: '); % 1
    beta_A = input('Podaj beta [rad]: '); % 1
    gamma_A = input('Podaj gamma [rad]: '); 1
       
    disp('Punkt B - stop')
    x_B = input('Podaj x [m]: '); % -0.6046
    y_B = input('Podaj y [m]: '); % 0.8092
    z_B = input('Podaj z [m]: '); % -1.9221
    alpha_B = input('Podaj alpha [rad]: '); % 1
    beta_B = input('Podaj beta [rad]: '); % 0.5
    gamma_B = input('Podaj gamma [rad]: '); % 1 

% %Przykładowe dane
%     %disp('Punkt A - start');
%     x_A = -0.7717;
%     y_A = 0.6490;
%     z_A = -0.7012;
%     alpha_A = 1 ;
%     beta_A = 1;
%     gamma_A = 1;
%     
%     %disp('Punkt B - stop');
%     x_B = -0.6046;
%     y_B = 0.8092;
%     z_B = -1.9221;
%     alpha_B = 1;
%     beta_B = 0.5;
%     gamma_B = 1;

% Macierze orientacji, kąty obrotu wokół stałego układu odniesienia YXZ
    B_A=matrixByxz(alpha_A, beta_A, gamma_A);
    B_B=matrixByxz(alpha_B, beta_B, gamma_B);

% Zadanie odwrotne kinematyki
    [theta1_A,theta2_A,lambda3_A,zOdw_B30_A]=zadanieOdwrotne(x_A,y_A,z_A);
    [theta1_B,theta2_B,lambda3_B,zOdw_B30_B]=zadanieOdwrotne(x_B,y_B,z_B);

    % Sprawdzenie macierzy
    tol=0.001;
    f1=1; f2=1;
    for(i=1:3)
        for(j=1:3)
        if (abs(B_A(i,j)-zOdw_B30_A(i,j))>tol)
            f1=0;
        end
        if (abs(B_B(i,j)-zOdw_B30_B(i,j))>tol)
            f2=0;
        end
        end
    end

    if (f1==1 & f2==1)
        disp('Sprawdzenie macierzy: Zgodność macierzy pktA.')
    else
        disp('Sprawdzenie macierzy: Brak zgodności macierzy pktA, różnica w orientacji przedmiotu:')
        dif_A=B_A-zOdw_B30_A
    end
    
    if (f2==1)
        disp('Sprawdzenie macierzy: Zgodność macierzy pktA.')
    else
        disp('Sprawdzenie macierzy: Brak zgodności macierzy pktB, różnica w orientacji przedmiotu:')
        dif_B=B_B-zOdw_B30_B
    end

% Opcje wyboru planowania
    while(1)
    m = menu('Planowanie trajektorii, wybierz sposób planowania:','Wielomian 3-go stopnia','Wielomian 5-go stopnia','Wielomian 7-go stopnia','Interpolacja wielomianami stopnia 4-3-4','Zamknij okno');
        if m==1 
        trajektoria3(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B);
        elseif m==2
        trajektoria5(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B);
        elseif m==3
        trajektoria7(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B);
        elseif m==4
        trajektoria434(theta1_A, theta2_A, lambda3_A, theta1_B, theta2_B, lambda3_B);
        elseif m==5
        close
        break
        end
    end