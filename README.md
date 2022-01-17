# 5G-NR-Spatial-Correlated-MIMO-Channels
 Generate a correlated MIMO channel from a uncorrelated channel (random generated) based on correlation level 'Low','Med','MedA','High' specified in  3GPP 36.101, Annex B. These functions only applies to ULA cases.

  
  Author Dr J Mao
  
  Email: juquan.justin.mao@gmail.com
  
 2022 Feb
  
   
 ### Example:
 Generate 1000  2-by-2 MIMO spataial correlated channels and check the expected correlation matrix from these channels against the correlation matrix used to generate these channels
 
 
``` matlab
nRx = 2; 
nTx = 2;
corrLevel = 'high';
nRels = 1000;
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

%==============
>> example_run
The correlation matrix used to generate spatial correlated MIMO channels
    1.0000    0.9000    0.9000    0.8100
    0.9000    1.0000    0.8100    0.9000
    0.9000    0.8100    1.0000    0.9000
    0.8100    0.9000    0.9000    1.0000

The statistical correlation matrix obtained from random realized channels
    1.0046    0.9063    0.9079    0.8190
    0.9063    1.0075    0.8205    0.9115
    0.9079    0.8205    1.0095    0.9099
    0.8190    0.9115    0.9099    1.0107

  ```
