classdef realsenseSubscriberSO_ARM5 < matlab.System
    % System object to read color image, depth frame, pointcloud, and infrared from D415 RealSense camera.

    properties (Access = private)
        pipeline;     % RealSense pipeline object
        pointcloud;   % Pointcloud object
        width = 640;
        height = 480;
    end

    properties (Nontunable)
        FilePath = "C:\Program Files (x86)\Intel RealSense SDK 2.0\matlab"
    end

    methods (Access = protected)
        function setupImpl(obj)
            addpath(obj.FilePath);

            obj.pipeline = realsense.pipeline();
            obj.pointcloud = realsense.pointcloud();

            config = realsense.config();
            config.enable_stream(realsense.stream.color, obj.width, obj.height, realsense.format.rgb8, 15);
            config.enable_stream(realsense.stream.depth, obj.width, obj.height, realsense.format.z16, 15);
            config.enable_stream(realsense.stream.infrared, 1, obj.width, obj.height, realsense.format.y8, 15); % IR izquierda

            obj.pipeline.start(config);

            for i = 1:10
                obj.pipeline.wait_for_frames();
            end
        end

        function [colorImage, orderedPointCloud, depthImage, irImage] = stepImpl(obj)
            frameset = obj.pipeline.wait_for_frames();

            % Color
            colorFrame = frameset.get_color_frame();
            colorData = colorFrame.get_data();
            colorImage = permute(reshape(colorData', [3, obj.width, obj.height]), [3, 2, 1]);

            % Depth
            depthFrame = frameset.get_depth_frame();
            depthData = depthFrame.get_data();
            depthImage = reshape(depthData', [obj.width, obj.height])';

            % Point cloud
            obj.pointcloud.map_to(colorFrame);
            points = obj.pointcloud.calculate(depthFrame);
            vertices = points.get_vertices();
            orderedPointCloud = permute(reshape(vertices, obj.width, obj.height, []), [2, 1, 3]);

            % Infrared
            irFrame = frameset.get_infrared_frame(1); % IR izquierda
            irData = irFrame.get_data();
            irImage = reshape(irData', [obj.width, obj.height])';
        end

        function releaseImpl(obj)
            obj.pipeline.stop();
        end

        % Output configs
        function [f1, f2, f3, f4] = isOutputFixedSizeImpl(~)
            f1 = true; f2 = true; f3 = true; f4 = true;
        end

        function [s1, s2, s3, s4] = getOutputSizeImpl(obj)
            s1 = [obj.height, obj.width, 3];  % RGB
            s2 = [obj.height, obj.width, 3];  % PointCloud (XYZ)
            s3 = [obj.height, obj.width];     % Depth
            s4 = [obj.height, obj.width];     % Infrared
        end

        function [t1, t2, t3, t4] = getOutputDataTypeImpl(~)
            t1 = 'uint8';   % RGB
            t2 = 'double';  % Point cloud
            t3 = 'uint16';  % Depth (z16)
            t4 = 'uint8';   % IR (y8)
        end

        function [c1, c2, c3, c4] = isOutputComplexImpl(~)
            c1 = false; c2 = false; c3 = false; c4 = false;
        end
    end

    methods(Static, Access = protected)
        function simMode = getSimulateUsingImpl
            simMode = "Interpreted execution";
        end

        function flag = showSimulateUsingImpl
            flag = false;
        end
    end
end
