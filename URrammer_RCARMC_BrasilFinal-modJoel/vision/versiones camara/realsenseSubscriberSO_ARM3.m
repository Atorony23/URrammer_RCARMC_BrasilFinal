classdef realsenseSubscriberSO_ARM3 < matlab.System
    % realsenseSubscriberSO System object to read color images and pointclouds from D415 RealSense camera.
%[colorImg, pointCloud, irImg] = realSense.step; %para mandarlo a llamar 
    properties (Access = private)
        % Private properties
        pipeline; % RealSense pipeline object
        width = 640; % Image width
        height = 480; % Image height
        pointcloud; % Pointcloud
    end

    properties (Nontunable)
        FilePath = "C:\Program Files (x86)\Intel RealSense SDK 2.0\matlab"
    end

    methods (Access = protected)
        function setupImpl(obj)

            %Include perception MATLAB wrapper to path
            addpath(obj.FilePath);

            % Initialize the RealSense camera
            % Create a pipeline object
            obj.pipeline = realsense.pipeline();

            % Initialize the pointcloud
            obj.pointcloud = realsense.pointcloud();

            % Create a config object and enable the streams
            config = realsense.config();
            config.enable_stream(realsense.stream.color, obj.width, obj.height, realsense.format.rgb8, 15); % 15 in fps
            config.enable_stream(realsense.stream.depth, obj.width, obj.height, realsense.format.z16, 15);

            %  Agrega esta línea para el IR izquierdo
            config.enable_stream(realsense.stream.infrared, 1, obj.width, obj.height, realsense.format.y8, 15);

            % Start streaming
            obj.pipeline.start(config);
            
            % Remove auto-exposure configs
            % device = obj.pipeline.get_active_profile().get_device();
            % color_sensor = device.first.color_sensor();% Turn off auto-exposure
            % color_sensor.set_option(realsense.option.enable_auto_exposure, false); % Turn off auto white balance
            % color_sensor.set_option(realsense.option.enable_auto_white_balance, false);
            
            % ignore first few frames
            for i=1:10
                obj.pipeline.wait_for_frames();
            end
        end
        function [colorImage, orderedPointCloud, irImage,depth_frame] = stepImpl(obj)
        
            % Output the color image and point cloud from the RealSense camera

            % Wait for the next set of frames -- blocking**
            frameset = obj.pipeline.wait_for_frames();

            % Get the color frame
            colorFrame = frameset.get_color_frame();
            irFrame = frameset.get_infrared_frame(1);   % El "1" es la IR izquierda
            irData = irFrame.get_data();
            irImage = reshape(irData', [obj.width, obj.height])';
            
            colorImage = colorFrame.get_data();
            % Column vector to color matrix.
            colorImage = permute(reshape(colorImage', [3, colorFrame.get_width(), colorFrame.get_height()]), [3, 2, 1]);

            % Map the pointcloud to the color frame -- req. for aligning
            % depth to color image
            obj.pointcloud.map_to(colorFrame);

            % Get the depth frame
            depth_frame = frameset.get_depth_frame();
            % depth_data = py.numpy.asanyarray(depth_frame);
            % depthImage = uint16(depth_data);
            points = obj.pointcloud.calculate(depth_frame);

            % Generate the pointcloud from the vertices
            vertices = points.get_vertices();
            % Column vector to color matrix.
            orderedPointCloud = permute(reshape(vertices, obj.width, obj.height, []), [2,1,3]);
        end

        function releaseImpl(obj)
            % Release resources
            obj.pipeline.stop();
        end

        % Propagation methods
        function [flag1, flag2, flag3,flag4,flag5] = isOutputFixedSizeImpl(~)
            flag1 = true;   % Color image
            flag2 = true;   % Point cloud
            flag3 = true;
            flag4 = true;
            flag5= true;
        end
        
        function [size1, size2, size3,size4,size5] = getOutputSizeImpl(obj)
             % Return the sizes of the outputs
            size1 = [obj.height, obj.width, 3];   % colorImage
            size2 = [obj.height, obj.width, 3];   % orderedPointCloud
            size3 = [obj.height, obj.width];      % irImage
            size4 = [obj.height, obj.width];  %depth
            size5 = [obj.height, obj.width];
        end
     

        function [dataType1, dataType2, dataType3,dataType4,dataType5] = getOutputDataTypeImpl(~)
            dataType1 = 'uint8';    % colorImage
            dataType2 = 'double';   % point cloud
            dataType3 = 'uint8';    % irImage
            dataType4 = 'uint8';    % irImage
            dataType5 = 'uint16';    % irImage

        end

        function [flag1, flag2, flag3,flag4,flag5] = isOutputComplexImpl(~)
            flag1 = false;
            flag2 = false;
            flag3 = false;
            flag4 = false;
            flag5 = false;
        end
    end

    methods(Static, Access = protected)
        function simMode = getSimulateUsingImpl
            % Return only allowed simulation mode in System block dialog
            simMode = "Interpreted execution";
        end

        function flag = showSimulateUsingImpl
            % Return false if simulation mode hidden in System block dialog
            flag = false;
        end
    end
end