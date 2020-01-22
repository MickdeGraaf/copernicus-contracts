pragma solidity ^0.5.0;


import "./CopernicusToken.sol";

/**
 * This is a generic factory contract that can be used to mint tokens. The configuration
 * for minting is specified by an _optionId, which can be used to delineate various
 * ways of minting.
 */
contract CopernicusFactory {

  CopernicusToken public token;

  constructor(address _token) public {
    token = CopernicusToken(_token);
  }

  /**
   * Returns the name of this factory.
   */
  function name() external pure returns (string memory) {
    return "Copernicus Contract";
  }

  /**
   * Returns the symbol for this factory.
   */
  function symbol() external pure returns (string memory) {
    return "CPT";
  }

  /**
   * Number of options the factory supports.
   */
  function numOptions() external pure returns (uint256) {
    return 1;
  }

  /**
   * @dev Returns whether the option ID can be minted. Can return false if the developer wishes to
   * restrict a total supply per option ID (or overall).
   */
  function canMint(uint256 _optionId) external view returns (bool) {
    //   Cannot mint any other option than 0
    if(_optionId != 0) {
        return false;
    }

    if(token.totalSupply() < 21) {
        return true;
    }

    return false;
  }

  /**
   * @dev Returns a URL specifying some metadata about the option. This metadata can be of the
   * same structure as the ERC721 metadata.
   */
  function tokenURI(uint256 _optionId) external view returns (string memory) {
      return token.tokenURI(1);
  }

  /**
   * Indicates that this is a factory contract. Ideally would use EIP 165 supportsInterface()
   */
  function supportsFactoryInterface() external view returns (bool) {
      return true;
  }

  /**
    * @dev Mints asset(s) in accordance to a specific address with a particular "option". This should be
    * callable only by the contract owner or the owner's Wyvern Proxy (later universal login will solve this).
    * Options should also be delineated 0 - (numOptions() - 1) for convenient indexing.
    * @param _optionId the option id
    * @param _toAddress address of the future owner of the asset(s)
    */
  function mint(uint256 _optionId, address _toAddress) public {
    // TODO minting logic
    // TODO allow only opensea to call this method
    token.mint(_toAddress);
  }


    /**
   * Hack to get things to work automatically on OpenSea.
   * Use transferFrom so the frontend doesn't have to worry about different method names.
   */
  function transferFrom(address _from, address _to, uint256 _tokenId) public {
    mint(_tokenId, _to);
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function isApprovedForAll(
    address _owner,
    address _operator
  )
    public
    view
    returns (bool)
  {
    // if (owner() == _owner && _owner == _operator) {
    //   return true;
    // }

    // ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
    // if (owner() == _owner && address(proxyRegistry.proxies(_owner)) == _operator) {
    //   return true;
    // }

    // return false;
    return true;
  }

  /**
   * Hack to get things to work automatically on OpenSea.
   * Use isApprovedForAll so the frontend doesn't have to worry about different method names.
   */
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return address(this);
  }
}