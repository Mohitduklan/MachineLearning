function VectorImage = Image2Matrix(FileName="img.jpg") 
   #{ 
    Img3DMatRGB = imread(FileName);                #loading image in RGB 3D formet
    Img3DMatYIQ = rgb2ntsc(Img3DMatRGB);
    Img2DMatBW  = Img3DMatYIQ(:,:,1);
    OldSize = size(Img2DMatBW);
    CropPercentage = 100;
    CropDelta = floor(( OldSize-min(OldSize)) .* CropPercentage/100);
    FinalSize = OldSize-CropDelta;
    CropOrigin = floor(CropDelta/2) + 1;
    CopySize = CropOrigin + FinalSize - 1;
    CroppedImage = Img2DMatBW( CropOrigin(1):CopySize(1), CropOrigin(2):CopySize(2));
    Scale = [20 20] ./ FinalSize ;
    NewSize = max(floor(Scale .* FinalSize),1); 
    RowIndex = min(round(((1:NewSize(1))-0.5)./Scale(1)+0.5), FinalSize(1));
    ColIndex = min(round(((1:NewSize(2))-0.5)./Scale(2)+0.5), FinalSize(2));
    NewImage = CroppedImage(RowIndex,ColIndex,:);
    InvertedImage = - NewImage;
    MaxValue = max(InvertedImage(:));
    MinValue = min(InvertedImage(:));
    Delta = MaxValue - MinValue;
    NormImage = (InvertedImage - MinValue) / Delta;
    ContrastedImage =sigmoid(NormImage -.5)*.5 ;
    imshow(ContrastedImage, [-1, 1] );
    VectorImage = reshape(ContrastedImage, 1, NewSize(1)*NewSize(2));
    #}
    a=[ [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0];
        [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; ];
        
        VectorImage=a(:)';
endfunction