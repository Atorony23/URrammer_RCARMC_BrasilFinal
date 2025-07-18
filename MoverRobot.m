function [jointAngles,H_Actual_Mesa]= MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur) %falta el "ur"
    %Manda la posicion del efector, en donde lo queremos, ocupamos darle los
    %velores de coci = coordenadas_cilindricas(r,theta,h)
    %Punto 3d que el usuario quiere alcanzar
    p_real = rah2p(coci);

    %Punto 3d que el robot quiere alcanzar
    p_robot = mi_Rotz(defase_Robot)*p_real;

    %Angulo necesario del Gripper para mantener una posición radial + el
    %ajuste del usuario
    temp = p2rah(p_robot);
    nuevo_Angulo_Gripper = temp(2) + angulo_Gripper + defase_Robot;

    %Se construye la matriz de transformación homogénea
    H_Actual_Robot = [RGrip(nuevo_Angulo_Gripper),p_robot;0 0 0 1];
    H_Actual_Mesa =  [0 -1 0 0; ...
                      1 0 0 0;...
                      0 0 1 0;
                      0 0 0 1] * H_Actual_Robot;

    %Aqui entramos con los datos de cinemtica inversa y datos anteriores
    %del posicion del cobot
    jointAngles = InverseKinematicUR5eITESMTampico2025(H_Actual_Robot,jointAngles);
    
    %Mandamos los valores articulares obtenidos de la funcion de cinematica
    %inversa directo al cobot, dentro de la funcion colocamos el objeto al
    %que lo mandamos "ur", los valores que le mandamos "jointAngles", el
    %tiempo en el que queremos que finalice 'EndTime', y el valor en
    %segundos, en este caso en segundos
    [~,~] = sendJointConfigurationAndWait(ur,jointAngles,'EndTime',2);

end

%Funciones locales del programa -------------------------------------------

function output = RGrip(AngGrip)
%Ingresa el angulo de rotación del griper, este siempre apunta con el eje z
%hacia abajo.
    output = [cos(AngGrip) sin(AngGrip) 0;...
             sin(AngGrip) -cos(AngGrip) 0;...
              0    0   -1];
end

function output = p2rah(p)
%Recibe un punto en coordenadas cartesianas y lo translada a coordenadas
%cilíndricas (x,y,z)-->(radio,angulo,altura)
    output = [norm([p(1),p(2)]); 
              atan2(p(2),p(1)) ;      
              p(3) ];
end

function output = rah2p(p)
%Recibe un punto en coordenadas cilíndricas y lo translada a coordenadas
% (radio,angulo,altura) --> (x,y,z)
    output = [p(1)*cos(p(2)) ;
              p(1)*sin(p(2)) ;
              p(3)];
end

function output = mi_Rotz(theta)
%Ingreso un ángulo en RADIANES y devuelve la respectiva matriz de rotación en z.
    output = [cos(theta) -sin(theta) 0;
              sin(theta) cos(theta) 0;
              0 0 1];
end