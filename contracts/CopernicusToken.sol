pragma solidity ^0.5.0;
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/Address.sol";
import "./Strings.sol";

contract CopernicusToken is Ownable, ERC721Full {

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
    string memory _baseTokenUri,
    address _tokenReceiver
  ) ERC721Full(_name, _symbol) public {
    maxSupply = _maxSupply;
    baseTokenUri = _baseTokenUri;
    tokenPrice = _tokenPrice;

    for(uint256 i = 0; i < 21; i++) {
      if(i < 9) {
        _mint(_tokenReceiver, totalSupply() + 1);
      } else {
        _mint(msg.sender, totalSupply() + 1);
      }
      
    }
  }

  function tokenURI(uint256 tokenId) external view returns (string memory) {
        return baseTokenUri.strConcat(
            Strings.uint2str(tokenId)
        ).strConcat(".json");
        // return baseTokenUri;
    }
}
