// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EcoDeposit {
    address public owner;
    uint256 public depositAmount = 0.01 ether; // Monto del depósito en garantía (0.01 ETH)

    // Estructura para rastrear cada envase entregado
    struct Bottle {
        address customer;
        bool isActive;
    }

    // Mapea un ID único de botella a su estado actual
    mapping(uint256 => Bottle) public bottles;

    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el administrador puede hacer esto");
        _;
    }

    constructor() {
        owner = msg.sender; // El comercio o institución que administra el contrato
    }

    // 1. REGISTRO: El cliente compra la bebida y deja el depósito en garantía
    // El comercio llama a esta función asociando el ID de la botella a la billetera del cliente
    function contractRegisterDeposit(uint256 _bottleId, address _customer) external payable onlyOwner {
        require(msg.value == depositAmount, "Debes enviar el monto exacto del deposito");
        require(!bottles[_bottleId].isActive, "Esta botella ya esta registrada en circulacion");

        bottles[_bottleId] = Bottle(_customer, true);
    }

    // 2. RETORNO: El cliente devuelve la botella y el contrato le reembolsa automáticamente
    // Implementa el método moderno .call para evitar obsolescencia por cambios de GAS en la red
    function returnBottle(uint256 _bottleId) external {
        require(bottles[_bottleId].isActive, "Esta botella no esta registrada o ya fue devuelta");
        
        address customerAddress = bottles[_bottleId].customer;
        bottles[_bottleId].isActive = false; // Desactivamos el registro inmediatamente para evitar doble reclamo

        // Transferencia segura utilizando las mejores prácticas de la EVM actual
        (bool success, ) = payable(customerAddress).call{value: depositAmount}("");
        require(success, "La transferencia fallo");
    }
}
