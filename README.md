# SimpleKalman
SimpleKalman is a very simple 1-dimensional Kalman filter that is written as clearly as possible as a soft introduction.

* * * 

Here's the setup:
  You have a very simple robot on a track that has two (noisy) sensors:
  
*   An odometry sensor that tells you how far your robot has moved since the last timestep
*   An absolute sensor that tells you the actual position of the robot. Also, this sensor can only be read every 20 timesteps.

* * * 

Remember, both of these sensors are _noisy_, and won't give particularly precise readings. Note, however, that the sensors have different characteristics that we would like to take advantage of:
  
*   The odometry sensor can be read very quickly, and so we can use it to update our estimated position on every timestep. Unfortunately, because it only tells us the distance it thinks we've traveled since the last timestep, relying on this sensor alone will cause us to _drift_! Check out the green circles in the plot to see what happens when we just integrate our velocity.
*   The measurement sensor can only be read slowly, and has larger noise than the odometry, _however_ it's noisy readings are always centered around the true position of the robot. This means that the readings from the measurement sensor will never drift off to Mars.

* * *

The point of a Kalman filter is to "optimally" integrate these two kinds of sensors, trying to take advantage of their best characteristics. It does this by keeping track of the current amount of noise in the system, and then mixing in measurements according to how much noise they will introduce.

## Running

Running SimpleKalman is easy - just fire up MATLAB or Octave, cd to the directory of this repo, and type "SimpleKalman".

A plot window should pop up, showing the robot's actual trajectory in blue.

As the simulation runs, you should see:

-   Green circles showing what our prediction would look like if we just integrated the odometry (pretty bad, right? Check out that drift!)
-   Red stars showing the occasional measurements. Notice how they're usually pretty inaccurate.
-   Black dots showing the Kalman filtered prediction. 

Try messing around with the variables processNoise and measurementNoise in SimpleKalman.m, and note what effect they have on our filter's output.
