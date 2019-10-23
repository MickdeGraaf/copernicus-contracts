pragma solidity ^0.5.0;
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/Address.sol";
import "./Strings.sol";

contract CopernicusToken is ERC721Full, Ownable {

  using Address for address;
  using Strings for string;

  uint256 public maxSupply;
  uint256 public tokenPrice;
  string public baseTokenUri;

  constructor(
    string memory _name,
    string memory _symbol,
    uint256 _maxSupply,
    uint256 _tokenPrice,
    string memory _baseTokenUri
  ) ERC721Full(_name, _symbol) public {
    maxSupply = _maxSupply;
    baseTokenUri = _baseTokenUri;
    tokenPrice = _tokenPrice;
  }

  function buyToken() external payable {
    require(totalSupply() < maxSupply, "MAX_SUPPLY_REACHED");
    require(msg.value <= tokenPrice, "MSG_VALUE_TOO_LOW");
    _mint(msg.sender, totalSupply());
  }

  function withdraw() external {
    address(uint160(owner())).transfer(address(this).balance);
  }

  function tokenURI(uint256 tokenId) external view returns (string memory) {
        return baseTokenUri.strConcat(
            Strings.uint2str(tokenId)
        );
    }
}
