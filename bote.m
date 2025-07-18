function [jointAngles,coci]=bote(angulo_Gripper,defase_Robot,jointAngles,ur,bandera)
    %Se movera sobre el bote
    if bandera > 0
        pb = [-0.53,0.19]; %coord xy del bote verde
    else
        pb = [-0.53,0.49]; %Coord del bote azul
    end
    coci = car2pol(pb(1),pb(2),0.3);
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    pause(2.5)
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2.5)
end