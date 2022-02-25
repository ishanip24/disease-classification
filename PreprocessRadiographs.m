%% crop border and crop to square

clear
files = dir('*.jpeg');

for iteration = 1:length(files)
    
    clear -except [iteration, files]
    close all
    
    file = files(iteration).name;
    %disp(file)
    raw = imread(file);
    [row, col] = size(raw);
    
    % crop border
    x1 = [20, 50]; % upper left hand crop point
    y1 = [col - 20, row - 50]; % bottom right hand crop point
    
    
    crop1 = raw(x1(2):y1(2) , x1(1):y1(1));  % creates cropped image
    %figure;
    %imshow(crop1) % checking cropped image
    
    % crop to square
    [row, col] = size(crop1); % new cropped dimensions
    
    centerpt = [col/2, row/2]; % center point
    
    if row > col
       diff = (row - col)/2;
       x2 = [1, diff]; % upper left hand crop point
       y2 = [col, row - diff]; % bottom right hand crop point
       crop2 = crop1(x2(2):y2(2) , x2(1):y2(1)); % creates cropped square image
    elseif col > row
        diff = (col - row)/2;
        x2 = [diff, 1]; % upper left hand crop point
        y2 = [col - diff, row]; % bottom right hand crop point
        crop2 = crop1(x2(2):y2(2) , x2(1):y2(1)); % creates cropped square image
    else
        crop2 = crop1;        
    end
    
    %figure;
    %imshow(crop2)
    
    
    % output jpeg
    imwrite(crop2, strcat(extractBefore(file, '.jpeg'), '.jpeg'))

    clear -except [files]

end



%% convert grayscale to rgb

clear
files = dir('*.jpeg');

for iteration = 1:length(files)
    
    clear -except [iteration, files, output_folder]
    close all
    
    file = files(iteration).name;
    %disp(file)
    gs = imread(file);
    [row, col] = size(gs);
    
    rgb = zeros(row, col, 3);
    rgb(:, :, 1) = gs;
    rgb(:, :, 2) = rgb(:, :, 1);
    rgb(:, :, 3) = rgb(:, :, 1);
    rgb = rgb/255;
    
    %figure;
    %imshow(rgb)
    
    
    % output jpeg
    imwrite(rgb, strcat(extractBefore(file, '.jpeg'), '.jpeg'))

    clear -except [files, output_folder]

end



%% increase contrast histeq

clear
files = dir('*.jpeg');

for iteration = 1:length(files)
    
    clear -except [iteration, files]
    close all
    
    file = files(iteration).name;
    %disp(file)
    im = imread(file);
    im = im2gray(im);

    im_histeq = histeq(im);
    
    
    %figure;
    %imshow(im_histeq)
    
    
    % output jpeg
    imwrite(im_histeq, strcat(extractBefore(file, '.jpeg'), '.jpeg'))

    clear -except [files]

end
