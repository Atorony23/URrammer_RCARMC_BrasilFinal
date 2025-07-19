function [jointAngles,coci]=bote(angulo_Gripper,defase_Robot,jointAngles,ur,bandera)
    %Se movera sobre el bote
    if bandera > 0
        coci = car2pol(-0.21,0.3,0.335);
        jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
        pause(1.5)
        pb = [-0.53,0.06]; %coord xy del bote verde
    else
        coci = car2pol(-0.21,0.3,0.335);
        jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
        pause(1.5)
        pb = [-0.53,0.36]; %Coord del bote azul
    end
    coci = car2pol(pb(1),pb(2),0.3);
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    pause(2.5)
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2.5)
end