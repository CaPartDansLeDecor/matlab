function [] = CompressionImage2(qualite)

warning('off', 'Images:initSize:adjustingMag');

%lecture de l'image et conversion en classe double pour l'utiliation de SVD
inputImage = imread('imageMystere2.jpg');
inputImage = im2double(inputImage);

%d�composition de l'image en 3 matrices RGB
inputImageRed = inputImage(:,:,1);
inputImageGreen = inputImage(:,:,2);
inputImageBlue = inputImage(:,:,3);

%d�composition en valeur singuli�res de chaque couche, en supprimant les
%z�ros de la matrice diagonale ('econ')
[URed, DRed, VRed] = svd(inputImageRed,'econ');
[UGreen, DGreen, VGreen] = svd(inputImageGreen,'econ');
[UBlue, DBlue, VBlue] = svd(inputImageBlue,'econ');

%mise � z�ro des valeurs singuli�res de rang sup�rieur � la qualit�
%demand�e
NbValSing = size(DRed);


DRed(floor(qualite*NbValSing):end,:) = 0;
DRed(:,floor(qualite*NbValSing):end) = 0;

DGreen(floor(qualite*NbValSing)+1:end,:) = 0;
DGreen(:,floor(qualite*NbValSing)+1:end) = 0;

DBlue(floor(qualite*NbValSing)+1:end,:) = 0;
DBlue(:,floor(qualite*NbValSing)+1:end) = 0;

%reconstitution de chaque couche
outputImageRed = URed*DRed*VRed';
outputImageGreen = UGreen*DGreen*VGreen';
outputImageBlue = UBlue*DBlue*VBlue';

%reconsitution de l'image de sortie par concat�nation des RGB
outputImage = cat(3, outputImageRed, outputImageGreen, outputImageBlue);

%affichage de l'image compress�e
imshow(outputImage);





end

