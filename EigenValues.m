function [ valeurPropreMax, vecteurPropreMax, vecteurPropreTMax ] = EigenValues( A )

%erreur max sur pour le test de colin�arit�
epsilon = 10^-8;

[m,n] = size(A);

X = rand(m,1);
Y = rand(m,1);

P = rand(1,m);
Q = rand(1,m);

%m�thode des puissances it�r�es avec test de colin�arit� seulement une fois
%sur deux endomorphismes successifs afin de s'affranchir des probl�mes li�s
%aux valeurs propres n�gatives
while(abs(dot(X,Y) - norm(X)*norm(Y)) > epsilon) %test de colin�arit�
        X = Y/norm(Y);
        Y1 = A*X;
        Y1 = Y1/norm(Y1);
        Y = A*Y1;

end

%m�thode des puissances it�r�es
while(abs(dot(P,Q) - norm(P)*norm(Q)) > epsilon)
        P = Q/norm(Q);
        Q1 = P*A;
        Q1 = Q1/norm(Q1);
        Q = Q1*A;
end

%test du signe de la valeur propre
if (dot(Y,Y1) < 0)
    valeurPropreMax = -norm(Y)/norm(Y1);
else 
    valeurPropreMax = norm(Y)/norm(Y1);
end

vecteurPropreMax = Y;
vecteurPropreTMax = Q;

end