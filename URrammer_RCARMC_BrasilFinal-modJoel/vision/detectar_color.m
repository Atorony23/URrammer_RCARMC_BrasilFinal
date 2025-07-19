function colorLabel = detectar_color(rgb)
    % Prueba cada máscara de color en orden
    if any(mascara_cubo_rojo(rgb), 'all')
        colorLabel = "Rojo";
    elseif any(mascara_cubo_azul(rgb), 'all')
        colorLabel = "Azul";
    elseif any(mascara_cubo_verde(rgb), 'all')
        colorLabel = "Verde";
    elseif any(mascara_cubo_morado(rgb), 'all')
        colorLabel = "Morado";
    else
        colorLabel = "Ninguno";
    end
end