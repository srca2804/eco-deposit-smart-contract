# Eco-Deposit: Decentralized Deposit-Refund Smart Contract

This repository contains the core smart contract implementation for **Eco-Deposit**, a decentralized Deposit-Refund System (DRS) designed to internalize single-use plastic consumption externalities using the Ethereum Virtual Machine (EVM) architecture.

## 🚀 Project Overview
Eco-Deposit leverages blockchain state-machine logic to automate the collection and return of packaging deposits without relying on centralized clearinghouses. 

1. **Deposit Registration:** When a bottle is sold, the merchant triggers the contract, escrowing a predefined deposit amount (`0.01 ether`) and linking a unique cryptographic bottle ID to the consumer's wallet address.
2. **Atomic Settlement:** Upon validated return at an authorized collection point, the contract executes an atomic transfer, returning the deposit to the consumer and updating the bottle state to prevent double-reclamation.

## 🛠️ Tech Stack & Implementation
- **Language:** Solidity (^0.8.0)
- **Environment:** EVM-Compatible (Optimized for LACNet Testnet)
- **Development Tooling:** Remix IDE

## 💡 Microeconomic Optimization: GAS Constraints
To prevent the *Tragedy of the Commons* on shared public testnets like LACNet, the contract enforces a **minimalist design constraint** to drastically reduce GAS consumption per block:
- **No Unbounded Loops:** Avoids dynamic array iterations, ensuring $O(1)$ transactional complexity.
- **State-Storage Optimization:** Limits persistent state writes (`SSTORE`) strictly to unique bottle IDs and address mappings, minimizing production costs.

## 📂 Repository Structure
- `/contracts/EcoDeposit.sol`: The main Solidity smart contract.

## 📋 How to Run the Demo (Remix IDE)
1. Copy the code from `contracts/EcoDeposit.sol`.
2. Open [Remix IDE](https://remix.ethereum.org/).
3. Create a new file named `EcoDeposit.sol` and paste the code.
4. Compile using Solidity compiler version `0.8.0` or higher.
5. Go to the "Deploy & Run Transactions" tab, select "Remix VM" environment, and deploy the contract.
6. Use the `contractRegisterDeposit` function with a mock address and `0.01 ETH` value, then execute `returnBottle` with the same ID to verify the automated refund.
