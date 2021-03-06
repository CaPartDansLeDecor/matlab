function [] = ModulationAmplitudeMinimalReel(typeSpectre)

close all;
%set(0,'DefaultFigureWindowStyle','docked')

a = - 5;
b = 5;
N = 16384;
fe = N/(b-a);
te = 1/fe;

xt = linspace(a,b-te,N);    % N intervalles -> il faut s'arr�ter � b-T
xf = linspace(-fe/2,fe/2-1/(b-a),N);    %idem

f1 = 100;
f2 = 400;

s1 = zeros(1,N);
s2 = zeros(1,N);
c = zeros(1,N);
d1 = zeros(1,N);
d2 = zeros(1,N);

for n=1:N
    t = (n-1)*te + a;
    s1(1,n)= cos(2*pi*2*t) + cos(2*pi*4*t) + cos(2*pi*6*t) + cos(2*pi*8*t) + cos(2*pi*10*t);
    s2(1,n)= 5*cos(2*pi*2*t) + 4*cos(2*pi*4*t) + 3*cos(2*pi*6*t) + 2*cos(2*pi*8*t) + cos(2*pi*10*t);
    
    %modulation
    c(1,n) = s1(1,n)*cos(2*pi*f1*t) + s2(1,n)*cos(2*pi*f2*t);
    
    %d�modulation
    d1(1,n) = c(1,n)*cos(2*pi*f1*t);
    d2(1,n) = c(1,n)*cos(2*pi*f2*t);
end

figure('units','normalized');

%Amplitude/Phase
if (typeSpectre==0)
    subplot(3,2,1);
    plot(xf,real(tfour(s1)));
    title('spectre(s1)')
    
    subplot(3,2,2);
    plot(xf,real(tfour(s2)));
    title('spectre(s2)')
    
    subplot(3,2,[3,4]);
    plot(xf,real(tfour(c)));
    title('spectre(c)')
        
    subplot(3,2,5);
    plot(xf,real(tfour(d1)));
    title('spectre(d1)')
    
    subplot(3,2,6);
    plot(xf,real(tfour(d2)));
    title('spectre(d2)')
    
end

%Partie R�elle/Imaginaire
if (typeSpectre==1)
    subplot(3,2,1);
    plot(xf,abs(tfour(s1)));
    title('module(s1)')
    
    subplot(3,2,2);
    plot(xf,abs(tfour(s2)));
    title('module(s2)')
    
    subplot(3,2,[3,4]);
    plot(xf,abs(tfour(c)));
    title('module(c)')
    
    subplot(3,2,5);
    plot(xf,abs(tfour(d1)));
    title('module(d1)')

    subplot(3,2,6);
    plot(xf,abs(tfour(d2)));
    title('module(d2)')
   
end

end