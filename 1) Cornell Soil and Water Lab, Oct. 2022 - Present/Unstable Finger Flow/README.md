# Unstable Finger Flow 💧🌾🔬

SUMMARY
- aided Naaran Brindt (post-doc, Cornell Soil and Water Lab) in writing code that was used for the first set of 
  experiments in this paper: https://www.sciencedirect.com/science/article/pii/S0309170824000484 ...code is above in this folder

- overall purpose was to better visualize water movement through pores at the fingertip of an unstable finger flow

- a high-speed camera recorded the imbibtion of water in air-dry sand...this code used MATLAB Image Processing Toolbox 
  to track the location of the moving fingertip in each video frame

- the output is the row number in each frame of fingertip edge...knowing the dimensions of each pixel and the frame rate, 
  these row numbers could be used to calculate the distance the fingertip traveled and it's velocity

- these calculations were then used for Figures 3 and 4 in the paper to demonstrate the hydraulic jumps that occured between pores 
  during flow and to show matric potential discontinuity

- I wrote the loop listed under "Part 2" after discussing the idea with Naaran...we worked out an example in "Part 1" on a couple 
  of video frames, and then I applied it to the entire video file with the loop
