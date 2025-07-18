function [rgbImg, depthImg,irImage] = fotosw(realSense)
    % Use step method to snap new images
    [rgbImg, depthImg,irImage] = realSense.step;
    
    % Show rgb image
    imshow(rgbImg)
    
    % Visualize point cloud
    %figure
    %pcloud=pointCloud(depthImg);
    %pcshow(pcloud)
    
    % Check depthImg depth dimension
    figure
    imshow(depthImg(:,:,3))
    
    % Snap image and check if it is worth saving
    %[rgbImg, depthImg] = realSense.step;
    %imshow(rgbImg)
end