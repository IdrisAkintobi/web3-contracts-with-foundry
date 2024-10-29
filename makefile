# Load environment variables from .env
include .env
export $(shell sed 's/=.*//' .env)

# Formatting and Testing prerequisite
.PHONY: check
check:
	forge fmt
	forge build
	forge test

# Deployment targets
Voting: check
	forge script script/Voting.s.sol --rpc-url lisk-sepolia --broadcast --verify

MulticallV2: check
	forge script script/MulticallV2.s.sol --rpc-url lisk-sepolia --broadcast --verify

ProposalContract: check
	forge script script/ProposalContract.s.sol --rpc-url lisk-sepolia --broadcast --verify

TokenWithRoles: check
	forge script script/TokenWithRoles.s.sol --rpc-url lisk-sepolia --broadcast --verify

TimeLockedWallet: check
	forge script script/TimeLockedWallet.s.sol --rpc-url lisk-sepolia --broadcast --verify

AreaCalculator: check
	forge script script/AreaCalculator.s.sol --rpc-url lisk-sepolia --broadcast --verify

IDrisNFT: check
	forge script script/IDrisNFT.s.sol --rpc-url lisk-sepolia --broadcast --verify

Crowdfunding: check
	forge script script/Crowdfunding.s.sol --rpc-url lisk-sepolia --broadcast --verify

IDrisSVGOncChainNFT: check
	forge script script/IDrisSVGOncChainNFT.s.sol --rpc-url lisk-sepolia --broadcast --verify

IDrisSVGOncChainNFT-local: check
	forge script script/IDrisSVGOncChainNFT.s.sol --rpc-url localhost --broadcast
	# Ensure the DO_NOT_KEY is updated in the env file.
