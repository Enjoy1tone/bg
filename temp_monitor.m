function temp_monitor()
   
% Initialize temperature variables
duration = 600; % Duration for 10 minutes (600 seconds)
temperature_data = zeros(1, 600); % Preallocate temperature data array
count = 1; % Initialize the counter for the temperature data array

% Set up the plot
figure;
h = animatedline;
xlim([0, 600]); % Show a span of 10 minutes
ylim([-50, 50]); % Limit the temperature range
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature Profile');

% Main loop running for the specified duration
Curent_Time = tic; % Start the overall timer
    
   
    while count <= duration % Loop indefinitely until terminated by the user
        A0_voltage = readVoltage(a, 'A0');  % Read the temperature sensor voltage
        temperature = (A0_voltage - 0.5) / 0.01;  % Calculate the temperature  
        temperature_data(count) = temperature;  % Store the temperature data
        
        % LED controlled according to temperature
        if temperature > 24 % Temperatures above 24°C
        writeDigitalPin(a, "D2", 0); %  green off
        writeDigitalPin(a, "D7", 1); % red on
        pause(0.25); % Short delay for immediate reaction
        writeDigitalPin(a, "D7", 0); % red off

    elseif temperature < 18 % Temperatures below 18°C
        writeDigitalPin(a, "D2", 0); %  green off
        writeDigitalPin(a, "D4", 1); %   yellow on
        pause(0.5); % Short delay for immediate reaction
        writeDigitalPin(a, "D4", 0); %   yellow off

    else % Temperatures in the range of 18-24°C
        writeDigitalPin(a, "D2", 1); %  green on
        end

        % Check if one second has passed to update the plot
            while toc(Curent_Time) >= count

            % Update the plot with the new temperature data
            addpoints(h, count, temperature);
            drawnow;
        
            % Increment the counter
            count = count + 1;
            end
     end
    
% Nitialization of Variables:

% Moved the initialization of count to the top with other initializations 
% for better organization and readability.
 
% The use of addpoints and drawnow remains appropriate for real-time 
% updating of the plot.
