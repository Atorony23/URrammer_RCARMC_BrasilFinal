 function [outputImg] = alineado(ir,rgb)
% Cargar imágenes
imgGray = ir;  % Imagen de profundidad o en escala de grises
imgRGB = rgb;    % Imagen rgb a alinear

% Asegurarse que ambas tienen tamaño base de 640x480
assert(isequal(size(imgGray,1), 480) && isequal(size(imgGray,2), 640), 'imgGray tamaño incorrecto');
assert(isequal(size(imgRGB,1), 480) && isequal(size(imgRGB,2), 640), 'imgRGB tamaño incorrecto');

% Escalar imagen RGB
scale = 0.63;
imgRGB_scaled = imresize(imgRGB, scale);

% Traslación
tx = 100;
ty = 90;

% Convertir imgGray a RGB para superposición
if size(imgGray, 3) == 1
    imgGray = repmat(imgGray, 1, 1, 3);
end

% Crear canvas negro del mismo tamaño que imgGray
canvas = zeros(size(imgGray), 'like', imgGray);

% Tamaño de la imagen escalada
[hs, ws, ~] = size(imgRGB_scaled);

% Calcular límites de inserción
x_start = max(1, 1 + round(tx));
y_start = max(1, 1 + round(ty));
x_end = min(size(imgGray,2), x_start + ws - 1);
y_end = min(size(imgGray,1), y_start + hs - 1);

% Recortar imagen escalada si se pasa de los bordes
imgRGB_crop = imgRGB_scaled(1:(y_end - y_start + 1), 1:(x_end - x_start + 1), :);
if size(imgRGB_crop, 3) == 1
    imgRGB_crop = repmat(imgRGB_crop, 1, 1, 3);  % convertir a RGB
end

% Superponer RGB encima de Gray (solo en la región deseada)
outputImg = imgGray;  % Base = imagen en escala de grises

% Reemplazar los píxeles RGB escalados
outputImg(y_start:y_end, x_start:x_end, :) = imgRGB_crop;


end