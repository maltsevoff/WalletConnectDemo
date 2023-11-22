# WalletConnectDemo

iOS Swift demo project of WalletConnect v2 SDK implementation on DApp side. 

## Sign protocol
Sign protocol implements two step wallet's authentication: wallet connection and sign request.
Wallet connection request returns wallet's address. 

## Auth protocol
Auth protocol implements one step wallet connection and authentication. This flow shows only one reqeust screen in user's wallet app which makes onboarding flow shorter.
DApp also recieves wallet's address and this protocol authenticate that user really owns this wallet.
BUT you won't be able to prepare transactions for wallet signing. 
