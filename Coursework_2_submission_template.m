% Guojun_Li_20514063
% ssygl2@notttingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

clear
clc
clear("a")
a=arduino;
while true
    writeDigitalPin(a,'D7',1)
    pause(0.5)
    writeDigitalPin(a,'D7',0)
end


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

clear
clc
clear("a")
a=arduino;

duration = 600;  % Duration in seconds
V0 = 0.5;
Tc = 0.01;
time_intervals = 0:1:duration;  % Time intervals for data acquisition
temperature_readings = zeros(1, length(time_intervals));  % Array to store temperature data

for i = 1:length(time_intervals)
    voltage = readVoltage(a, 'A0');  
    temperature_readings(i) = (voltage - V0) / Tc;  % Convert voltage to temperature
    pause(1);
end


% Calculate statistical quantities
min_temperature = min(temperature_readings);
max_temperature = max(temperature_readings);
avg_temperature = mean(temperature_readings);


% Create a plot of temperature against time
plot(time_intervals, temperature_readings);
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
title('Temperature vs. Time');


% Formatting and printing the data 
fprintf('Data logging initiated - 5/3/2024\n');
fprintf('Location - Nottingham\n\n');

for i = 1:length(time_intervals)
    if mod(time_intervals(i), 60) == 0
        minute = floor(time_intervals(i) / 60);
        temperature = temperature_readings(i);
        fprintf('Minute %d\n', minute);
        fprintf('Temperature  %.2f°C\n\n', temperature);
    end
end

fprintf('Max temp %.2f°C\n', max_temperature);
fprintf('Min temp %.2f°C\n', min_temperature);
fprintf('Average temp %.2f°C\n', avg_temperature);
fprintf('Data logging terminated  \n');


% Writing the formatted data to a file
fileID = fopen('cabin_temperature.txt', 'w');
fprintf(fileID,'Data logging initiated - 5/3/2024\n');
fprintf(fileID,'Location - Nottingham\n\n');

for i = 1:length(time_intervals)
    if mod(time_intervals(i), 60) == 0
        minute = floor(time_intervals(i) / 60);
        temperature = temperature_readings(i);
        fprintf(fileID,'Minute %d\n', minute);
        fprintf(fileID,'Temperature  %.2f°C\n\n', temperature);
    end
end

fprintf(fileID,'Max temp %.2f°C\n', max_temperature);
fprintf(fileID,'Min temp %.2f°C\n', min_temperature);
fprintf(fileID,'Average temp %.2f°C\n', avg_temperature);
fprintf(fileID,'Data logging terminated  \n');
fclose(fileID);


% To check the file content
fileID = fopen('cabin_temperature.txt', 'r');
file_content = fscanf(fileID,'%f', 1);
fclose(fileID);
disp(file_content)


%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

clear
clc
clear("a")
a=arduino;

temp_monitor(a)
    

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

clear
clc
clear("a")
a=arduino;

temp_prediction(a)


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

%Challenges:
% One of the primary challenges faced in this project was the real-time
% data processing and visualization of temperature

% Strengths:
%  These elements allow for immediate visual feedback and future
% temperature predictions, enhancing the utility of the system for
% real-time applications.

% Limitations:
% The current system relies heavily on continuous data streaming and
% processing, which can be resource-intensive and may
% not scale well with multiple sensors or over longer operational periods.

% Future Improvements:
% For future iterations of this project, several improvements are
% suggested:
% Optimization of data handling to reduce the load on the system's
% processing resources, possibly through more efficient
% These improvements would significantly enhance the system's
% functionality, making it more robust, scalable, and suitable for
% a broader range of applications in environmental monitoring and
% control systems.