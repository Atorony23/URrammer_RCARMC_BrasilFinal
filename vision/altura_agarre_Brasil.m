function [h_agarre,label] = altura_agarre_Brasil(label,z2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch label
        case "Lata" 
            if z2 > -0.1060
                h_agarre = -0.02;
                label = "Lata_parada";
            else 
                h_agarre = -0.09;
                label = "Lata_acostada";
            end
        case "Lata_parada"
                h_agarre = -0.02;
                label = "Lata_parada";
        case "Lata_acostada"
                h_agarre = -0.09;
                label = "Lata_acostada";
        case "Botella"    
            if z2 > -0.09
                h_agarre = 0.080;
                label = "Tapa";
            else       %%%Botella acostada
                h_agarre = -0.09;   %%valor z2 = 0.0203
            end
        case "Tapa"
                h_agarre = 0.080;
                label = "Tapa";
        case "Cubo"
            h_agarre = -0.097;
        case "SPAM"
            if z2 > -0.11
                h_agarre = -0.05800;
            else
                h_agarre = -0.09;
                label = "SPAM_acostado";
            end
        case "Plumon"
            h_agarre =  -0.0950;
      otherwise
   end
end