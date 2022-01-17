
%% 
nRx = 2; 
nTx = 2;
corrLevel = 'high';

nRels = 10000;

corrMtx = genMimoCorrMtx(nTx,nRx,corrLevel,0.0);
corrMtxRel = zeros(nRx*nTx);

for i = 1: nRels
    % Generate a uncorrelated MIMO channel
    H = randn(nRx,nTx);
    
    % make it correlated
    corrH = correlateMIMOChan(H,corrLevel);
    
    % accumulate the corrH(:)* corrH(:)'
     corrMtxRel = corrMtxRel + corrH(:)* corrH(:)';

end

% expected value: E( corrH(:)* corrH(:)')
corrMtxRel = corrMtxRel/nRels;

disp("The correlation matrix used to generate spatial correlated MIMO channels")
disp(corrMtx)
disp("The statistical correlation matrix obtained from random realized channels")
disp(corrMtxRel)



