function [] = guardar_inf(colorImage,orderedPointCloud,irImage,H_actual,i,archivo)
colorImagefoto{i}=colorImage;
pCLOUD{i}=orderedPointCloud;
irIMAGEFOTO{i} = irImage;
H_actualB{i}=H_actual;
save(archivo,'pCLOUD','colorImagefoto',"irIMAGEFOTO","H_actualB")
end