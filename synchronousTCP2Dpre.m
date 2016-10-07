function [C] = synchronousTCP2Dpre(N,p,q)
%UNTITLED2 Summary of this function goes here
%   Every cell is marked as A(Y,X). Tri critical process.
A=zeros(N,N)+1;           %initial matrix
C=zeros(100000,1);
B=A;             %dummy matrix
for a=1:100000                  % time steps
    for i=1:N^2               % updating each cell in order
        Y=ceil(i/N);          % Y coordinate  
        X=i-N*(Y-1);          %X co-ordinate 
        U=randi(4);           %choose neighbor randomly
        if U==1                             %right neighbor
            P=(X+1)-N*floor(X/N);           %X co-ordinate of the neighbor
            Q=Y;                            %Y coordinate of the neighbor 
        elseif U==2                         %left neighbor  
            P=(X-1)+N*floor((N-X+1)/N);     %X co-ordinate of the neighbor
            Q=Y;                            %Y coordinate of the neighbor 
        elseif U==3                         %upper neighbor
            P=X;                            %X co-ordinate of the neighbor   
            Q=(Y-1)+N*floor((N-Y+1)/N);     %Y co-ordinate of the neighbor
        else                                %lower neighbor
            P=X;                            %X co-ordinate of the neighbor
            Q=(Y+1)-N*floor(Y/N);           %Y co-ordinate of the neighbor
        end
        if A(Y,X)==1                        %focal cell is occupied i.e. 1
            if A(Q,P)==1                    %if the neighbor is 1, given focal cell 1
                if rand(1)<=q               %looks for a 3rd neighbor
                    if U==1                 %if right neighbor was selected
                        V=randi(6);
                        if V==1                                 
                             B(Q,(P+1)-N*floor(P/N))=1;         %right neighbor of the pair was selected
                        elseif V==2                                  
                             B(Y,(X-1)+N*floor((N-X+1)/N))=1;   %left neighbor of the pair was selected
                        elseif V==3
                             B((Y-1)+N*floor((N-Y+1)/N),X)=1;   %neighbor above the focal cell was selected
                        elseif V==4
                             B((Y+1)-N*floor(Y/N),X)=1;         %neighbor below the focal cell was selected
                        elseif V==5
                             B((Q-1)+N*floor((N-Q+1)/N),P)=1;   %neighbor above the right neighbor was selected
                        else
                             B((Q+1)-N*floor(Q/N),P)=1;         %neighbor below the right neighbor was selected
                        end
                    elseif U==2             %if left neighbor was selected
                        V=randi(6);
                        if V==1                                 
                             B(Y,(X+1)-N*floor(X/N))=1;         %right neighbor of the pair was selected
                        elseif V==2                                  
                             B(Q,(P-1)+N*floor((N-P+1)/N))=1;   %left neighbor of the pair was selected
                        elseif V==3
                             B((Y-1)+N*floor((N-Y+1)/N),X)=1;   %neighbor above the focal cell was selected
                        elseif V==4
                             B((Y+1)-N*floor(Y/N),X)=1;         %neighbor below the focal cell was selected
                        elseif V==5
                             B((Q-1)+N*floor((N-Q+1)/N),P)=1;   %neighbor above the left neighbor was selected
                        else
                             B((Q+1)-N*floor(Q/N),P)=1;         %neighbor below the left neighbor was selected
                        end
                    elseif U==3             %if upper neighbor was selected
                        V=randi(6);
                        if V==1                                 
                             B(Y,(X+1)-N*floor(X/N))=1;         %right neighbor of the focal cell was selected
                        elseif V==2                                  
                             B(Y,(X-1)+N*floor((N-X+1)/N))=1;   %left neighbor of the focal cell was selected
                        elseif V==3
                             B((Q-1)+N*floor((N-Q+1)/N),P)=1;   %neighbor above the pair was selected
                        elseif V==4
                             B((Y+1)-N*floor(Y/N),X)=1;         %neighbor below the pair was selected
                        elseif V==5
                             B(Q,(P+1)-N*floor(P/N))=1;         %neighbor right to the upper neighbor was selected
                        else
                             B(Q,(P-1)+N*floor((N-P+1)/N))=1;   %neighbor left to the upper neighbor was selected
                        end
                    else                    %if lower neighbor was selected
                        V=randi(6);
                        if V==1                                 
                             B(Y,(X+1)-N*floor(X/N))=1;         %right neighbor of the focal cell was selected
                        elseif V==2                                  
                             B(Y,(X-1)+N*floor((N-X+1)/N))=1;   %left neighbor of the focal cell was selected
                        elseif V==3
                             B((Y-1)+N*floor((N-Y+1)/N),X)=1;   %neighbor above the pair was selected
                        elseif V==4
                             B((Q+1)-N*floor(Q/N),P)=1;         %neighbor below the pair was selected
                        elseif V==5
                             B(Q,(P+1)-N*floor(P/N))=1;         %neighbor right to the upper neighbor was selected
                        else
                             B(Q,(P-1)+N*floor((N-P+1)/N))=1;   %neighbor left to the upper neighbor was selected
                        end
                    end
                else                        %doesn't look for 3rd pair
                    if rand(1)<=1-p         %dies with probability (1-p)(1-q) 
                        B(Y,X)=0;
                    end
                end
            else                      %if focal is occupied and neighbor is empty 
                if rand(1)<=p
                    B(Q,P)=1;         %germination from p process
                else
                    B(Y,X)=0;         %death (1-p) from p process
                end
            end
        end
    end                           % after all cells are updated
    A=B;
    C(a,1)=sum(sum(A));               % density after that time step   
end
end