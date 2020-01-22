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
  address public minter;

  constructor(
    string memory _name,
    string memory _symbol,
    uint256 _maxSupply,
    uint256 _tokenPrice,
    string memory _baseTokenUri,
    address _tokenReciever
  ) ERC721Full(_name, _symbol) public {
    maxSupply = _maxSupply;
    baseTokenUri = _baseTokenUri;
    tokenPrice = _tokenPrice;

    for(uint256 i = 0; i < 9; i++) {
      _mint(_tokenReciever, totalSupply() + 1);
    }
  }

  function setMinter(address _minter) external {
    // TODO limit setting minter
    require(minter == address(0), "MINTER_ALREADY_SET");
    minter = _minter;
  }

  function mint(address _to) external {
    require(msg.sender == minter, "NOT_MINTER");
    _mint(_to, totalSupply() + 1);
  }

  function buyToken() external payable {
    require(totalSupply() < maxSupply, "MAX_SUPPLY_REACHED");
    require(msg.value >= tokenPrice, "MSG_VALUE_TOO_LOW");
    _mint(msg.sender, totalSupply() + 1);
  }

  function withdraw() external {
    address(uint160(owner())).transfer(address(this).balance);
  }

  function tokenURI(uint256 tokenId) external view returns (string memory) {
        return baseTokenUri.strConcat(
            Strings.uint2str(tokenId)
        ).strConcat(".json");
        // return baseTokenUri;
    }
}
