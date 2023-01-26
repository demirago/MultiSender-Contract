// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

contract MultisenderUpgradable is
    Initializable,
    OwnableUpgradeable,
    UUPSUpgradeable
{
    using SafeMathUpgradeable for uint256;
    using SafeMathUpgradeable for uint16;
    using AddressUpgradeable for address;

    receive() external payable {}

    function initialize() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}

    /*SendBNBEqually
        # First parameter is array of address.
        # This function will divide the msg.value with length of total adddress  
            (value = msg.value / length of address) and send that value one by one equally.
    */

    function SendBNBEqually(address payable[] calldata _address)
        external
        payable
        returns (bool)
    {
        uint16 length = uint16(_address.length);
        uint sendValue = msg.value.div(length);
        for (uint16 i; i < length; ++i) {
            _address[i].transfer(sendValue);
        }

        return true;
    }

    /*SendBNBEquallyByValue 
        # First parameter is array of address.
        # This function will send msg.value to all adddress one by one.
        # Must check the total BNB balance must be equal to msg.value * length of address you 
            provided, before calling this function. If the balance is low this function will
            revert with an error and gas fees will be levied.
    */

    function SendBNBEquallyByValue(
        address payable[] calldata _address,
        uint256 _value
    ) external payable returns (bool) {
        uint16 length = uint16(_address.length);
        for (uint16 i; i < length; ++i) {
            _address[i].transfer(_value);
        }

        return true;
    }

    /*SendBNBByValue
        # First parameter is array of address.
        # Second parameter is array of values to send.
        # This function will send BNB's first value to first address and so on.
        # Address length and value length must be same or the function will revert with an error.
    */

    function SendBNBByValue(
        address payable[] calldata _address,
        uint256[] calldata _value
    ) external payable returns (bool) {
        uint16 length = uint16(_address.length);
        uint16 valueLength = uint16(_value.length);
        require(length == valueLength, "Address & Value Length mismatched");
        for (uint16 i; i < length; ++i) {
            _address[i].transfer(_value[i]);
        }

        return true;
    }

    /*SendTokensEqually
        # First parameter is array of address.
        # Second parameter is total tokens value.
        # This function will divide the token value with length of total adddress
            (value = token value / length of address) and send that token value one by one equally.
    */

    function SendTokensEqually(
        address _tokenAddress,
        address[] calldata _address,
        uint256 _value
    ) external returns (bool) {
        uint16 length = uint16(_address.length);
        uint sendValue = _value.div(length);

        for (uint16 i; i < length; ++i) {
            IERC20Upgradeable(_tokenAddress).transferFrom(
                msg.sender,
                _address[i],
                sendValue
            );
        }

        return true;
    }

    /*SendTokensEquallyByValue 
        # First parameter is array of address.
        # Second parameter is value.
        # This function will send token value to all adddress one by one.
        # Must check the total token balance must be equal to value * length of address you 
            provided, before calling this function. If the token balance is low this function will
            revert with an error and gas fees will be levied.
    */

    function SendTokensEquallyByValue(
        address _tokenAddress,
        address[] calldata _address,
        uint256 _value
    ) external returns (bool) {
        uint16 length = uint16(_address.length);

        for (uint16 i; i < length; i++) {
            IERC20Upgradeable(_tokenAddress).transferFrom(
                msg.sender,
                _address[i],
                _value
            );
        }

        return true;
    }

    /*SendTokensByValue
        # First parameter is array of address.
        # Second parameter is array of values to send.
        # This function will send Tokens first value to first address and so on.
        # Address length and value length must be same or the function will revert with an error.
    */

    function SendTokensByValue(
        address _tokenAddress,
        address[] calldata _address,
        uint256[] calldata _value
    ) external returns (bool) {
        uint16 length = uint16(_address.length);
        uint16 valueLength = uint16(_value.length);
        require(length == valueLength, "Address & Value Length mismatched");
        for (uint16 i; i < length; i++) {
            IERC20Upgradeable(_tokenAddress).transferFrom(
                msg.sender,
                _address[i],
                _value[i]
            );
        }

        return true;
    }

    // Get the balance of all the BNB present in this smart contract

    function BNBBalance() external view returns (uint256 balance) {
        balance = address(this).balance;
        return balance;
    }

    // Get the balance of tokens present in this smart contract

    function TokensBalance(address _tokenAddress)
        external
        view
        returns (uint256 balance)
    {
        IERC20Upgradeable(_tokenAddress).balanceOf(address(this));
        return balance;
    }

    // Withdraw BNB from this smart contract

    function withdraw(address _address, uint256 _value) external onlyOwner {
        payable(_address).transfer(_value);
    }

    // Withdraw tokens from this smart contract

    function withdrawTokens(address _tokenAddress, uint256 _value)
        external
        onlyOwner
    {
        IERC20Upgradeable(_tokenAddress).transfer(_msgSender(), _value);
    }
}
