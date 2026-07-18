
# Eco-Deposit: Decentralized Deposit-Refund Smart Contract for Sustainable Circular Economy

**Hackathon:** *Innovating for a Sustainable Future*  
**Event Dates:** May 13 – June 15, 2025 
**Case Study Context:** Lima, Peru — Urban Solid Waste Management and Informal Recycling Incentives

---

## 📝 1. Abstract
Urban plastic pollution in high-density developing-country cities such as Lima, Peru, reflects a persistent market failure in which the private cost of single-use packaging diverges from its true social cost. Eco-Deposit addresses this failure through a Solidity smart contract, deployed on the EVM-compatible LACNet infrastructure, that automates a decentralized Deposit-Refund System (DRS) for plastic bottles. By collecting a refundable deposit at the point of sale and programmatically returning it upon verified collection, the protocol eliminates the verification, settlement, and intermediation costs that cause conventional deposit schemes to fail. The result is a transaction-cost-minimizing mechanism that internalizes environmental externalities and realigns individual consumer incentives with socially optimal recycling behavior.

### 🎯 Strategic Objectives
* **Objective 1 (Sustainability):** To foster environmental sustainability by aligning individual economic incentives with urban circular economy loops.
* **Objective 2 (Innovation):** To leverage decentralized EVM smart contracts to mitigate structural market failures and transaction costs in developing regions.

---

## 📊 2. Microeconomic Framework & The Externality Model

### 2.1 Context and Empirical Data (Lima, Peru)
The Lima metropolitan area exhibits severe structural inefficiencies in waste management:
* **Volume and Recycling Rates:** Lima generates approximately 8,500 tons of garbage daily—accounting for nearly half of Peru's total output—yet a mere 4% is formally recycled. At a national level, daily waste exceeds 22,000 tons.
* **Environmental Burden:** Plastic accounts for roughly 1/10 of all household waste, and nearly half of the debris found on Peruvian beaches consists of long-lasting plastic materials.
* **Collection Deficits:** Only about 55% of municipal solid waste nationwide was properly collected and disposed of as of 2020, leaving the rest to accumulate in informal open dumps, rivers, or oceans.

### 2.2 Mathematical Model
Eco-Deposit introduces a temporary deposit ($D \approx MEC$) functioning as a temporal Pigouvian tax-subsidy pair. It shifts the consumer's private opportunity cost of improper disposal from zero to $OC_{discard} = D$, bringing the market from a suboptimal private equilibrium ($Q_{market}$) to a socially efficient allocation ($Q_{social}$):


```

Price/Cost
^
|                                    SMC = PMC + MEC
|                                   /
|                                  /
|                            *DWL*/
|                            /|  /
|                          /  | /
P* |------------------------/---|/---------------  <- Social Optimum Price
|                       /    /
|                     /|    /|
P0 |-------------------/--|---/-|------------------ <- Private Market Price
|                  /   |  /  |         PMB
|                /     |/    |        /
|              /      /|     |      /
|            /       / |     |    /
|          /        /  |     |  /
|        /         /   |     |/
|------/----------/----|----/------------------> Quantity
|    /           /     |   /
|  /            /      |  /
+-------------------------------------------------
Q_social    Q_market

Legend:
PMC  = Private Marginal Cost (bottling firm's supply curve)
SMC  = Social Marginal Cost = PMC + MEC (Marginal External Cost)
PMB  = Private Marginal Benefit (aggregate consumer demand)
Q_social  = Efficient quantity where PMB = SMC
Q_market  = Actual market quantity where PMB = PMC
DWL  = Deadweight Loss triangle, bounded by SMC, PMB, between
Q_social and Q_market — the uncompensated cost imposed
on third parties by overproduction/overconsumption.

```

---

## 🛠️ 3. Technical Solution & Architecture

The smart contract collapses traditional verification, accounting, and clearinghouse frictions into a single, self-executing EVM state machine:
* **Stage 1 — Registration:** At the point of sale, the contract escrows a refundable deposit (`0.01 ether`) and registers a unique cryptographic identifier mapped to the consumer's wallet address.
* **Stage 2 — Return and Settlement:** Upon container return at an authorized collection point or Reverse Vending Machine (RVM), the contract validates the ID, triggers an atomic refund, and deactivates the token state to prevent double-reclamation.

### 💡 Gas Scarcity Constraints on LACNet
LACNet (orchestrated by the IDB Lab as a permissioned public blockchain based on Hyperledger Besu) enforces a strict per-block GAS ceiling on its free tier. To prevent a *Tragedy of the Commons*, our architecture applies rigid microeconomic design discipline to computational resources:
* **No Unbounded Loops:** Ensures $O(1)$ algorithmic complexity by omitting dynamic array iterations.
* **Minimalist Storage Writes:** Restricts persistent `SSTORE` calls strictly to structural bottle mappings.
* **Modern Safe Transfers:** Uses the secure, modern `.call{value: ...}("")` method rather than the legacy `.transfer` function to handle refunds without gas-cap vulnerability.

---

## 📂 4. Repository Structure
* `/contracts/EcoDeposit.sol`: Core Solidity smart contract.
* `/README.md`: System specification and theoretical documentation.

---

## 📋 5. Local Emulation (Remix IDE)
1. Copy the source from `/contracts/EcoDeposit.sol`.
2. Open [Remix IDE](https://remix.ethereum.org/).
3. In the *File Explorer*, create `EcoDeposit.sol` inside the `contracts/` directory and paste the code.
4. Go to the **Solidity Compiler** tab, choose version `0.8.0` (or higher), and compile.
5. Go to the **Deploy & Run Transactions** tab, select a **Remix VM** environment, and click **Deploy**.
6. Interact with the Deployed Contract:
   * **Registration:** Call `contractRegisterDeposit` entering a numerical bottle ID, the customer's mock address, and providing exactly `0.01 ether` in the *Value* field.
   * **Redemption:** Call `returnBottle` with the same ID to execute the instantaneous, automated refund.

---

## 🗺️ 6. Post-Hackathon Roadmap & Policy Scalability

Global precedents, such as Singapore's recent nationwide deployment of roughly 2,000 cash-refund RVMs, demonstrate that deposit-based behavioral mechanisms are highly scalable[cite: 3]. Eco-Deposit upgrades this paradigm by substituting manual/cash clearinghouse systems with an automated, zero-intermediary ledger.

* **Phase 1 — Local Pilot (Months 1–3):** Implementation within a controlled, high-density setting in Lima (e.g., a university campus or recycling cooperative) to track state transitions against real transaction volumes.
* **Phase 2 — IoT Automation (Months 4–6):** Interfacing the contract with physical RVM hardware via IoT automated oracles for 24/7 autonomous verification.
* **Phase 3 — Macro-Scale Integration (Months 6+):** Enterprise deployment helping bottling conglomerates fulfill Extended Producer Responsibility (EPR) regulations. The contract natively interfaces with Peru's current circular economy data tracking ecosystem, which monitors PET/HDPE recovery via the government's *Sigersol Municipal* platform under Supreme Decree No. 001-2022-MINAM.

---

## 📚 References
* Bloomberg. (2026, March 18). *Singapore wants empty bottles back to reduce plastic waste.*
* G20MPL (Towards Osaka Blue Ocean Vision). (2025). *Peru: Circular economy and plastics recovery roadmap.*
* Interactive Country Fiches, UNEP/GRID. (2024). *Pollution / Peru.*
* Ledger Insights. (2022, February 24). *Latin American regional blockchain network LACNet officially launches.*
* Molpack. (2025, November 3). *Recycling in Peru: A stretch to go with steps already taken.*
* ScienceDirect. (2024, October 30). *The potential of Deposit Refund Systems in closing the plastic beverage bottle loop: A review.*
* Woima Corporation. (2024, February 20). *Drowning in waste – Case Lima, Peru.*
* WWF Peru. (2021). *Almost 90% of the garbage generated daily is not recycled.*

```
