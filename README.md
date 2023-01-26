1-npm install
2-Create .env file to the root folder and put the private keys in this format or create variable of your own and update them in hardhat.config.js

MAINNET_PRIVATE_KEY = YOUR MAINNET PRIVATE KEY (AVAOID PUTIING HERE UNTIL YOU ARE DEPLOYING ON MAINNET AND TESTED ON TEST NETWORKS)
TESTNET_PRIVATE_KEY = YOUR TESTNET PRIVATE KEY (KEEP MAINNET AND TESTNET PRIVATE KEYS SPERATE)
BSC_API_KEY = YOUR CONTRACT VERIFICATION API KEYS. I OBTAINED FROM BSCSCAN.COM. CHECK ON DIFFERENT NETWORKS

DEPLOYMENT
3-npx hardhat compile
4-npx hardhat run scripts/deploy_MultiSender.jsx (will deploy on your default network configured in hardhat.config.js )


(--network bsctestnet for bsc testnet or bsc for mainnet or choose your own network)

RUN AND VERİFY

5-npx hardhat verify "ADDRESS OF DEPLOYED SMART CONTRACT"

(--network bsctestnet for bsc testnet or bsc for mainnet or choose your own network)



