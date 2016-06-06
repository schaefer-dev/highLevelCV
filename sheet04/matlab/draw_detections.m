function draw_detections(imgname, detections)
    
  % ... 
  figure();
  width = 120;
  height = 30;
  yellow = uint8([255 255 0]);
  shapeInserter = vision.ShapeInserter('BorderColor', 'Custom', 'CustomBorderColor', yellow);
  img = imread(imgname);
  
  rect = [];
  for i = 1:size(detections,1)
      px = detections(i,1) * 10;
      py = detections(i,2) * 10;
      rect = [rect; px-width/2.0 py-height/2.0 width height];
  end
  res = step(shapeInserter, img, int32(rect));
  imshow(res)
end


