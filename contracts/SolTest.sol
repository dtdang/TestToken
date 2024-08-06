// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SolToken is ERC20 {
    constructor() ERC20("SolToken", "ST") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}
