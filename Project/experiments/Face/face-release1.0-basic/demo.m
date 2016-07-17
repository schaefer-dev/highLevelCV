%path to images folder
img_path = '../../../data/train/';
%name of the classes
img_classes = {'c4'};
%in which image to start
start_at = 1;
%choose -1 to process them all, otherwise how many you want to process  
quantity = -1; 
%you can make it false if the model is already in memory
train = true;

% change this depending on your operating system (\ windows, / unix)
path_seperator='/';



if train

    % compile.m should work for Linux and Mac.
    % To Windows users:
    % If you are using a Windows machine, please use the basic convolution (fconv.cc).
    % This can be done by commenting out line 13 and uncommenting line 15 in
    % compile.m
    compile;

    % load and visualize model
    % Pre-trained model with 146 parts. Works best for faces larger than 80*80
    load face_p146_small.mat

    % % Pre-trained model with 99 parts. Works best for faces larger than 150*150
    % load face_p99.mat

    % % Pre-trained model with 1050 parts. Give best performance on localization, but very slow
    % load multipie_independent.mat

    disp('Model visualization');
    visualizemodel(model,1:13);
    disp('press any key to continue');
    %pause;
    close all;


    % 5 levels for each octave
    model.interval = 5;
    % set up the threshold
    model.thresh = min(-0.65, model.thresh);

    % define the mapping from view-specific mixture id to viewpoint
    if length(model.components)==13 
        posemap = 90:-15:-90;
    elseif length(model.components)==18
        posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
    else
        error('Can not recognize this model');
    end
end

for c = 1:length(img_classes)
   img_class = img_classes{c};

    %If the file doesn't exist, write its header before using
    if exist(fullfile(cd, [img_class,'.csv']), 'file') ==0
        fid = fopen([img_class,'.csv'], 'w');
        x = 1:68;    

        XY=strcat(', X1(',num2str(x(:)),')',', Y1(',num2str(x(:)),')',...
            ', X2(',num2str(x(:)),')',', Y2(',num2str(x(:)),')');
        XY= XY'
        XY= XY(:);

        fprintf(fid, '%s, %s, %s, %s, %s','img_num', 'Name', 'Class', 'Pose', 'quant' ) ;
        fprintf(fid,'%s', XY(:));    
        fprintf(fid, '\n');
        fclose(fid);
    end

    %load all images in folder 
    ims = dir([img_path,img_class,'/*.jpg']);

    %Set an appropriate end_at based on start_at and quantity
    end_at = start_at;
    if start_at > length(ims)
       fprintf('Start_at exceeds number of images\n');   
    elseif quantity <0
        end_at = length(ims);
        fprintf('quantity negative, testing all images\n');   
    elseif start_at + quantity -1 > length(ims)
        end_at = length(ims);
        fprintf('Insufficient images, testing until the end\n');   
    else
        end_at = start_at + quantity -1;
        fprintf('Well defined bounds\n');   
    end
 
    fprintf(['Starting tests for class: ' img_class '\n\n']);

    fid = fopen([img_class,'.csv'], 'a');

    for i = start_at:end_at,

        fprintf('testing: %s %d/%d\n', img_class,  i, length(ims));

        % UNIX read:
        im = imread([img_path,img_class,path_seperator, ims(i).name]);
        
        
        %uncomment to crop,
        %im = imcrop(im,[0 0 size(im,2)-1, size(im,1)]);
        %figure; imagesc(im); axis image; axis off; drawnow;

        tic;
        bs = detect(im, model, model.thresh);
        bs = clipboxes(im, bs);
        bs = nms_face(bs,0.3);
        dettime = toc;
        fprintf('Detection took %.1f seconds\n',dettime);

        %write only if a face was found
        if length(bs) > 0  

            %make array from the boxes
            xy = bs(1).xy';
            xy = xy(:);    

            %Write line into file with results
            fprintf(fid, '%d, %s, %s, %d %d', i, ims(i).name, img_class, posemap(bs(1).c), length(xy)/4);
            fprintf(fid, sprintf(', %f', xy(:)));
            fprintf(fid, '\n');

            %Save progress
            fclose(fid) ;
            fid = fopen([img_class,'.csv'], 'a');


            % show highest scoring one, uncomment next line if you want to see
            % detection
            %figure,showboxes(im, bs(1),posemap),title('Highest scoring detection');

            % show all
            %figure,showboxes(im, bs,posemap),title('All detections above the threshold');

            %fprintf('Detection took %.1f seconds\n',dettime);
            %disp('pr ess any key to continue');
            %pause;
            %close all;

        else        
            fid2 = fopen('undetected.csv', 'a');        
            fprintf(fid2, '%d, %s, %s\n',i, img_class, ims(i).name);
            fclose(fid2);    
        end;


    end

    fclose(fid) ;

    disp('done!');
end;
