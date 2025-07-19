function coci = car2pol(x,y,z)
    r = min(0.91,sqrt(x^2+y^2)); %1
    theta = atan2(y,x); %2
    h_deseada = z; %3
    h_posible = min(h_deseada,sqrt((1-(r/0.89)^2)*0.9^2)); %4
    coci = [r,theta,h_posible]; %5
end

%0--Esta funcion es la encargada de convertir coordenadas cartesianas
    %(x,y,z) a coordenadas cilindricas (r,theta,altura)

%1--Calculamos el radio con una limitante de 0.91 lo que permitira que no
    %pueda encontar una solucion mas lejos de ese punto, ya que esta truncado

%2--Calculamos el angulo theta utilizando el arco tangente, para poder ir
    %hacia todos los cuadrantes

%3--La altura corresponde directamente al valor ordenado en el eje z de los
    %valores cartesianos

%4--La altura deseada se busca limitar en base al valor del radio maximo,
    %se busca formar una tipo semielipsoide, que limite el espacio con respecto
    %al radio que tenga el cobot, esto llevado a que con respecto a que el
    %valor de r aumenta, el valor de la altura disminuya

%5--Devolvemos el valor en un vector de las coordenadas cilindricas ya
    %truncadas