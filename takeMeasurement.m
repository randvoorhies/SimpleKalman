function z = takeMeasurement()
  % Generate a noisy measurement given the current state of the system.
  % Note that I'm using globals here in order to make it appear as though 
  % this is some 'real system' that's taking 'real' measurements. 
  global realpos;
  global t;
  measurementNoise = 0.15;

  z = normrnd(realpos(t), measurementNoise);
end
