function Rspat = genMimoCorrMtx(neNBAnts,nUEAnts,corr_level,a)
% @ Description: This function generate MIMO correlation matrix based on 3GPP 36.101, Annex B
% @ Input:
%       neNBAnts -  scalar value of number of eNodeB antennas
%       nUEAnts - number of UE antennas
%       corr_level - ULA MIMO correlation model:  'low','med','meda','high' options
% @ Output:
%       Rspat - a square combined corrlation matrix of (neNBAnts times nUEAnts)
    switch lower(corr_level)
        case 'low'
            alpha = 0; beta = 0;
        case 'med'
            alpha = 0.3; beta = 0.9;
        case  'meda'
            alpha = 0.3; beta = 0.3874;
        case 'high'
            alpha = 0.9; beta = 0.9;
        otherwise
            alpha = 0; beta = 0;
    end

    % Generate correlation matrix of NodeB side
    switch neNBAnts
        case 1
            Renb = 1;
        case 2
            Renb = toeplitz([1,alpha]);
        case 4
            Renb = toeplitz([1,alpha^(1/9),alpha^(4/9),alpha]);
        case 8
            Renb = toeplitz([1,alpha^(1/49),alpha^(4/49),alpha^(9/49),alpha^(16/49),alpha^(25/49),alpha^(36/49),alpha]);
        otherwise
            Renb = eye(neNBAnts);
    end
    
    % Generate correlation matrix of UE side
    switch nUEAnts
        case 1
            Rue = 1;
        case 2
            Rue = toeplitz([1,beta]);
        case 4
            Rue = toeplitz([1,beta^(1/9),beta^(4/9),beta]);
        case 8
            Rue = toeplitz([1,beta^(1/49),beta^(4/49),beta^(9/49),beta^(16/49),beta^(25/49),beta^(36/49),beta]);
        otherwise
            Rue = eye(neNBAnts);
    end
    
    % combined sptial correlation matrix
    Rspat = kron(Renb,Rue);

    %  "a" is a scaling factor such that the smallest value is used to make Rspat a positive semi-definite
    Rspat = (Rspat + a*eye(neNBAnts*nUEAnts))/(1+a);

end