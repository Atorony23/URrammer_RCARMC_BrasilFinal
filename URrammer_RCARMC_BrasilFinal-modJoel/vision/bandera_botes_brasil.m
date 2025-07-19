function [bandera] = bandera_botes_brasil(label)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch label
        case "Lata" 
            % Bote verde
           bandera = 1; 
        case "Lata_parada" 
            bandera = 1;
        case "Lata_acostada" 
            bandera = 1;
        case "SPAM"
            bandera = 1;
        case "SPAM_acostado"
            bandera = 1;
        case "Cubo_verde"
            bandera = 1;
        case "Cubo_morado"
            bandera = 1;       
        case "Botella"
            bandera = 0;
        case "Tapa"
            bandera = 0;
        case "Plumon"
            bandera = 0;
        case "Cubo_rojo" 
            bandera = 0;
        case "Cubo_azul"
            bandera =  0;
      otherwise
   end
end