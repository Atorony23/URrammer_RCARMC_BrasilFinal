function [jointAngles,coci,colorLabel]=bascula(coci,angulo_Gripper,defase_Robot,jointAngles,ur,realsense)
    %Se movera sobre la bascula
    puntosBasc = [-0.05, 0.56, 0.35]; %coord xyz de la bascula>>>>>------CAMBIAR------<<<<<<<
    n = 0.300;
    for e=1:1:4
        coci = car2pol(puntosBasc(1),puntosBasc(2),0.05+n);
        jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
        pause(0.25)
        n = n-0.100;
    end
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2)

    %Cerramos gripper
    actuateGripper(ur,'grip');
    %%Toma una foto
    [rgb, ~, ~]=realSense.step;
    colorLabel = detectar_color(rgb);

    %se activa despues la funcio "sube"
end