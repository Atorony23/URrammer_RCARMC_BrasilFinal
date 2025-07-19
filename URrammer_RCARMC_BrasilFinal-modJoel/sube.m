function jointAngles = sube(coci,jointAngles,defase_Robot,ur)
    %Hara que suba sobre el mismo punto
    h_deseada = 0.30;
    h_posible = min(h_deseada,sqrt((1-(coci(1)/0.91)^2)*0.6^2));
    coci = [coci(1),coci(2),h_posible];
    jointAngles = MoverRobot(coci,0,defase_Robot,jointAngles,ur);
end