function idx = buscarIndicePrioritario_Brasil(label2)
    % Lista de etiquetas en orden de prioridad
    prioridades = ["Lata", "Botella", "Plumon", "SPAM", "Cubo"];
    
    % Inicializar el índice como vacío
    idx = [];
    
    for i = 1:length(prioridades)
        actual = prioridades(i);
        idxs = find(label2 == actual);  % Buscar todos los índices
        if ~isempty(idxs)
            if actual == "Cubo"
                idx = idxs(1);  % Seleccionar el primero si es Cubo
            else
                idx = idxs(randi(length(idxs)));  % Selección aleatoria
            end
            return;  % Salir de la función con el índice seleccionado
        end
    end
end