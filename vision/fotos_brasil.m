function [I,I2,bboxes,scores,labels] = fotos_brasil(rgb,detector)
%%% TOMAR FOTOGRAFIA
% Paso 1 Tomamos foto RGB
I = rgb;
% % Paso 2 Tomamos foto profundidad
% prof = img;
% Páso 3 Activamos el Yolo : obtenemos las cajas, puntación y la clasificación
[bboxes,scores,labels] = detect(detector,I); 
% Paso 4 Insertamos los resultados para verificar  *quitar después
I2 = insertObjectAnnotation(I,"rectangle",bboxes,labels);
% figure(2)
% imshow(I2)
end