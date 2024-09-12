# Load environment variables from .env
include .env
export $(shell sed 's/=.*//' .env)

# Deployment target
AreaCalculator:
	forge script script/AreaCalculator.s.sol --rpc-url $(LISK_RPC_URL) --broadcast --verify

IDrisNFT:
	forge script script/IDrisNFT.s.sol --rpc-url $(SEPOLIA_RPC_URL) --broadcast --verify

Crowdfunding:
	forge script script/Crowdfunding.s.sol --rpc-url $(SEPOLIA_RPC_URL) --broadcast --verify

IDrisSVGOncChainNFT:
	forge script script/IDrisSVGOncChainNFT.s.sol --rpc-url $(SEPOLIA_RPC_URL) --broadcast --verify

IDrisSVGOncChainNFT-local:
	forge script script/IDrisSVGOncChainNFT.s.sol --rpc-url $(LOCALHOST) --broadcast
	# Ensure the DO_NOT_KEY is updated in the env file.
