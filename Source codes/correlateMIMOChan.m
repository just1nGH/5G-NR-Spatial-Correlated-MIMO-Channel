function corrH = correlateMIMOChan(H,corr_level)
% This function makes a uncorrelated spatial MIMO channel corrlated
% according to correlation level

    % obtain correlation matrix
    [nRx, nTx] = size(H);
    corrMtx = genMimoCorrMtx(nTx,nRx,corr_level,0.0);

    % correate the input uncorrelated MIMO channel
    RHermitan = chol(corrMtx)';
    corrH = reshape(RHermitan*H(:),nRx, nTx);

end

