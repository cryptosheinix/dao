// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract SheinixDAO is ERC1155, Ownable, Pausable {

  string public constant METADATA = "https://bafybeiblka4hlb3ficjfwepzzwl3i552bb2ldb3dq7tcmbaozcfqvwbf64.ipfs.dweb.link";

  constructor()
    ERC1155(METADATA)
  {}

  string public name = "Sheinix DAO NFT"; // NFT Name
  mapping(address => bool) public allowList; // Represents if an address is in the WL
  uint256 public pricePerToken = 0.001 ether; // Token mint price (could change)

  // Add an address(es) to WL (only allowed to the contract owner)
  function setAllowList(address[] calldata addresses) external onlyOwner {
    for (uint256 i = 0; i < addresses.length; i++) {
      allowList[addresses[i]] = true;
    }
  }

  // Change the mint price (only allowed to the contract owner)
  function changeMintPrice(uint256 _newPrice) external onlyOwner {
    pricePerToken = _newPrice;
  }

  // Mint a NFT (only allowed to addresses in the WL)
  function mintAllowList() external payable {
    require(allowList[msg.sender], "Address not Whitelisted");
    require(pricePerToken <= msg.value, "Ether value sent is not correct");

    allowList[msg.sender] = false;
    _mint(msg.sender, 0, 1, abi.encodePacked(uint16(0x12)));
  }

  // Set a new NFT metadata URI
  function setURI(string memory newuri) public onlyOwner {
    _setURI(newuri);
  }

  // Mint a NFT (only allowed to the contract owner)
  function mint(address account, uint256 id, uint256 amount, bytes memory data)
    public
    onlyOwner {
    _mint(account, id, amount, data);
  }

  // Mint a batch NFTs (only allowed to the contract owner)
  function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
    public
    onlyOwner {
    _mintBatch(to, ids, amounts, data);
  }

  // Withdraw the Ether from the contract to the owner address (only allowed to the contract owner)
  function withdraw() public onlyOwner {
    uint balance = address(this).balance;
    payable(msg.sender).transfer(balance);
  }

  /*
  *   function to pause and unpause the token transfers
  */

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data)
    public
    whenNotPaused
    override
  {
    _safeTransferFrom(from, to, id, amount, data);
  }
}
