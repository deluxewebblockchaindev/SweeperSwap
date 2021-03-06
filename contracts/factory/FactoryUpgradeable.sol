//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * ApeSwapFinance
 * App:             https://apeswap.finance
 * Medium:          https://ape-swap.medium.com
 * Twitter:         https://twitter.com/ape_swap
 * Telegram:        https://t.me/ape_swap
 * Announcements:   https://t.me/ape_swap_news
 * GitHub:          https://github.com/ApeSwapFinance
 */

import "./Factory.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev Standardized ApeSwap Upgrade Factory.
 * Extension of Clone Factory
 */
contract FactoryUpgradeable is Factory {
    address public proxyAdmin;

    constructor(address _implementation, address _admin) Factory(_implementation) {
        proxyAdmin = _admin;
    }

    /**
     * @dev deploy new contract of active implementation
     */
    function _deployNewContract() internal override returns (address newContract) {
        TransparentUpgradeableProxy newProxy = new TransparentUpgradeableProxy(
            address(implementations[contractVersion]),
            proxyAdmin,
            ""
        );
        newContract = address(newProxy);
        contracts.push(newContract);
        emit ContractDeployed(newContract);
    }
}
