function [] = guardar_inf(colorImage,orderedPointCloud,depthImage,irImage,H_actual,i)
deptFotoprueba{i}=depthImage;
colorImagefoto{i}=colorImage;
pCLOUD{i}=orderedPointCloud;
irIMAGEFOTO{i} = irImage;
H_actualB{i}=H_actual;
save('datos18_18','pCLOUD','deptFotoprueba','colorImagefoto',"irIMAGEFOTO","H_actualB")
end