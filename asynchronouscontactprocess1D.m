function [C] = asynchronouscontactprocess1D(N,p)
%UNTITLED2 Summary of this function goes here
%   Every cell is marked as A(Y,X). Normal contact process (asynchronous)
A=zeros(1,N);
L=randperm(N,N/2);
for i=1:N/2
    A(1,L(1,i))=1;
end 
C=zeros(200000,1);
for a=1:200000       % time steps
    for i=1:N      % updating each cell in ascending order
        X=i;        %X co-ordinate, Y is inherently 1
        U=randi(2);  %choose neighbor randomly
        if U==1        %right neighbor
            P=(X+1)-N*floor(X/N);      %X co-ordinate of the neighbor
        else             %left neighbor  
            P=(X-1)+N*floor((N-X+1)/N);  %X co-ordinate of the neighbor
        end
        if A(1,X)==1       %focal cell is occupied i.e. 1
            if A(1,P)==1                   %if the neighbor is 1, given focal cell 1
                if rand(1)<=1-p            %death with 1-p             
                    A(1,X)=0;
                end
            else
                if rand(1)<=1-p            %if the neighbor is 0, given focal cell 1
                     A(1,X)=0;             %death with 1-p 
                else
                    A(1,P)=1;              %germination with p
                end
            end
        end                           % after all cells are updated
    end
    C(a,1)=(sum(A))/N;                % density after that time step   
end
end
