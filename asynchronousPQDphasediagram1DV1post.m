function [C] = asynchronousPQDphasediagram1DV1post(N,p,q,d)
%UNTITLED2 Summary of this function goes here
%   Every cell is marked as A(Y,X). Tri critical process.
A=zeros(1,N);           %initial matrix
L=randperm(N,N/16);
for i=1:N/16
    A(1,L(1,i))=1;
end
C=zeros(500000,1);
for a=1:500000                  % time steps
    for i=1:N               % updating each cell in order
        X=i;                %X co-ordinate, as Y is inherently 1 
        U=randi(2);           %choose neighbor randomly
        if U==1                             %right neighbor
            P=(X+1)-N*floor(X/N);           %X co-ordinate of the neighbor
        else                                %left neighbor  
            P=(X-1)+N*floor((N-X+1)/N);     %X co-ordinate of the neighbor 
        end
        if A(1,X)==1                        %focal cell is occupied i.e. 1
            if A(1,P)==1                    %if the neighbor is 1, given focal cell 1
                if rand(1)<=q               %looks for a 3rd neighbor
                    if U==1                 %if right neighbor was selected
                        V=randi(2);
                        if V==1                                 
                             A(1,(P+1)-N*floor(P/N))=1;         %right neighbor of the pair was selected
                        else
                             A(1,(X-1)+N*floor((N-X+1)/N))=1;   %left neighbor of the pair was selected
                        end
                    else                    %if left neighbor was selected
                        V=randi(2);
                        if V==1                                 
                             A(1,(X+1)-N*floor(X/N))=1;         %right neighbor of the pair was selected
                        else                                  
                             A(1,(P-1)+N*floor((N-P+1)/N))=1;   %left neighbor of the pair was selected
                        end
                    end
               else                        %doesn't look for 3rd pair
                    if rand(1)<=d        %dies with probability d(1-q) 
                        A(1,X)=0;
                    end
                end
            else                      %if focal is occupied and neighbor is empty 
                if rand(1)<=p
                    A(1,P)=1;         %germination from p process
                end
                if rand(1)<=d
                    A(1,X)=0;         %death d from p process
                end
            end
        end
    end                           % after all cells are updated
C(a,1)=(sum(A))/N;                  % density after that time step   
end
end
