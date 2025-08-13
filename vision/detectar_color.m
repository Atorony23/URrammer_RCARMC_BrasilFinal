function colorLabel = detectar_color(rgb)
    % Prueba cada máscara de color en orden
    if any(mascara_cubo_rojo(rgb), 'all')
        colorLabel = "Cubo_rojo";
    elseif any(mascara_cubo_azul(rgb), 'all')
        colorLabel = "Cubo_azul";
    elseif any(mascara_cubo_verde(rgb), 'all')
        colorLabel = "Cubo_verde";
    elseif any(mascara_cubo_morado(rgb), 'all')
        colorLabel = "Cubo_morado";
    else
        colorLabel = "Ninguno";
    end
end