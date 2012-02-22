close all;
global realpos;
global t;
endtime = 100;
time = linspace(1,endtime, 1000);
realpos = sin(time/5);
plot(time, realpos);
hold on;

% The estimated noises of our process (AKA odometry, control), and measurement
processNoise     = 0.1;
measurementNoise = 0.1;

x = realpos(1);
p = processNoise;
unfilteredOdometry = x;
for t = 1:length(time)

  %-------------------- "Prediction Step" --------------------
  u = takeOdometry();
  x = x + u;
  p = p + processNoise;

  %-------------------- "Update Step" --------------------
  if mod(t, 10) == 0
    z = takeMeasurement();
    plot(time(t), z, 'r*');

    y = z - x;                         % Compute the 'residual': i.e. the difference between our estimated position,
                                       % and our absolute position measurement

    k = p / (p + measurementNoise);    % Compute the 'Kalman gain': i.e. the amount that we should trust this new absolute
                                       % measurement. Notice that when p is large relative to measurementNoise, k will be
                                       % close to 1. When measurement noise is large relative to p, k will be close to 0.
                                       % If p = measurementNoise, then k = 0.5.

    x = x + k*y;                       % Mix in the new absolute measurement proportional to k. If k is 1, then the new x = z. 
                                       % If k is 0, then the new x = x. If k is 0.5, then the new x = 0.5*x + 0.5*z. 

    p = (1 - k)*p;                     % The new process noise is decreased proportional to k.

  end

  plot(time(t), x, 'k.');

  % Plot the 'unfiltered odometry' in green: i.e. what we would see if we 
  % just tried to integrate the raw odometry readings without the kalman filter.
  unfilteredOdometry = unfilteredOdometry + u;
  plot(time(t), unfilteredOdometry, 'go');

  pause(0.05);
end
