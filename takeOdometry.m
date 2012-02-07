function u = takeOdometry()
  % Generate a noisy odometry (otherwise known as control) given the current
  % state of the system.  Note that I'm using globals here in order to make it
  % appear as though this is some 'real system' that's taking 'real'
  % measurements. 
  global t;
  global realpos;
  if t == 1
    u = 0;
  else
    processNoise = 0.05;
    u = normrnd(realpos(t) - realpos(t-1), processNoise);
  end
end
