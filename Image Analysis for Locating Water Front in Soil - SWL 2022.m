%{ 
SUMMARY
- aided Naaran Brindt (post-doc, Cornell Soil and Water Lab) in writing this code to track 
  a blue-dyed water front moving downwards through a soil medium in a video
- I wrote the loop listed under "Part 2" after discussing the idea with Naaran... 
  we worked out an example in "Part 1" on a couple of video frames, and then I applied it to the
  entire video file

POSSIBLE IMPROVEMENTS
- the variable "threshold" was a subjective variable based on what we saw from the output 
  through trial/error... this maybe could have been decided in a more scientific way, but that might have been overkill
- the second argument in the function bwareaopen(arg1, arg2) was also subjective based on 
  output through trial/error... same as the above point, could have been more scientifically derived, but maybe not necessary
%}

clear all
%% Part 1: This is a script for reading a video and saparating the RGB color bands
% make sure that the input data files are in the current folder
% 1. Read the video
v = VideoReader('RunB.avi');
% 2. recognize the last frame:
End_frame = v.Duration*v.FrameRate;
%% EXAMPLE: Creating pictures from the video, recognizing the wet parts.
% this is an example for creating the blue-red diferance image on the first image:
% 3. define the currant picture:
fig1=read(v,1);
% 5. isolating the Red band of the image
figredband= fig1(:,:, 1);
% 6. isolating the blue band of the image
figblueband= fig1(:,:, 3);
% 7. creating a blue-red difference matrix
bluereddif= figblueband-figredband;
% In case one of the figure analisys provides starnge results, you can plot
% the matix as a gray scale image.
% 8. example for plotting a fure inage figure
figure 
subplot(2,2,1)
imshow(fig1);
subplot(2,2,2)
imshow(figredband);
subplot(2,2,3)
imshow(figblueband);
subplot(2,2,4)
imshow(bluereddif);
%now Wat is left is to write the conabd where row number are recorded if
%they have a larger than zero Blue-Red-Difference and make it all in one
%loop

%% Part 2: Creating pictures from the video, recognizing the wet parts.
% loop that analyzes each frame to find bottom pixel row of liquid using
% the blue-red difference images

% init variables..."rows" contains row number for each frame respectively
% to indices where liquid ends, "threshold" is the max difference between 
% blue and red frames for the pixel to be considered not blue liquid
rows = [];
threshold = 10;   % NEEDS TO BE ADJUSTED!!!!

% iterate through and temporarily store each frame to be analyzed
for i = 1:End_frame
    fig = read(v,i);
    figredband = fig(:,:, 1);
    figblueband = fig(:,:, 3);
    bluereddif= figblueband-figredband;
    blackwhite = imbinarize(bluereddif, 0.05);  % imbinarize recommended??
    bwfinal = bwareaopen(blackwhite, 15);    % chose 15 based on visual inspection

    % iterate through each row and find where there is no more blue liquid
    j=1;
    while j > 0
        % test if at the end of 370 rows
        if (j > 370) 
            break

        % test if any pixels are blue, if so then keep iterating   
        elseif any(bwfinal(j,:) > 0)
            j = j + 1;

        % if not at the end of rows and a non-blue row is found, then save 
        % row number    
        else
            rows(i) = j-1;
            break
            
        end
    end
end



       

           



          

          

         
      









