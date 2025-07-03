%% Load data into variable
data = load('a3_s1_t3_skeleton.mat');
d_skeleton = data.d_skel; % 20 joints x 3 coordinates (x,y,z) x 48 slices(frames)

%% Bones Array
% 1. head; 
% 2. shoulder_center;
% 3. spine;
% 4. hip_center;
% 5. left_shoulder;
% 6. left_elbow;
% 7. left_wrist;
% 8. left_hand;
% 9. right_shoulder;
% 10. right_elbow;
% 11. right_wrist;
% 12. right_hand;
% 13. left_hip;
% 14. left_knee;
% 15. left_ankle;
% 16. left_foot;
% 17. right_hip;
% 18. right_knee;
% 19. right_ankle;
% 20. right_foot;
bones = [
    1 2;
    2 3;
    3 4;
    2 5;
    5 6; 
    6 7; 
    7 8; 
    2 9; 
    9 10;
    10 11;
    11 12;
    4 13;
    13 14;
    14 15;
    15 16;
    4 17;
    17 18;
    18 19;
    19 20;
    ];

%% Animate all joints over time
figure; % Create a figure

for t = 1:size(d_skeleton,3)
    coords = squeeze(d_skeleton(:, :, t)); % 20x3

    % Clear current frame
    clf
    hold on;
    
    % Plot all joints
    scatter3(coords(:, 1), coords(:, 2), coords(:, 3), 20, 'r', 'filled');

    % Plot all bones
    for b = 1:size(bones,1)
        i = bones(b, 1);
        j = bones(b, 2);
        plot3([coords(i, 1), coords(j, 1)], ...
        [coords(i, 2), coords(j, 2)], ...
        [coords(i, 3), coords(j, 3)], 'r-', 'LineWidth', 2);
    end


    % Decorate Plot
    axis([-1 1 -1.5 1 1 3.5]);
    xlabel('X'), ylabel('Y'), zlabel('Z');
    title(['Frame ' num2str(t)]);
    grid on;
   

    drawnow;

    movieVector(t) = getframe;
end

%% Save the animation
animation = VideoWriter('C:\Users\karen\Documents\gesture_research\Skeleton\skeleton_animation.mp4', 'MPEG-4');
animation.FrameRate = 10;

% Open the VideoWriter object, write the movie, and close the file
open(animation);
writeVideo(animation, movieVector);
close(animation);