// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

interface ERC20Interface {
    function transfer(address, uint256) external returns (bool);
    function approve(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Marketplace2 {
    struct Product {
        address payable owner;
        string name;
        string image;
        string description;
        string location;
        uint price;
        uint soldCount;
    }

    uint internal productCount = 0;

    // cUSD ERC-Token address from the Celo alfajores test network
    address internal cUSDTokenaddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    mapping(uint => Product) public products;

    function createProduct(string memory _name, 
            string memory _image,
            string memory _description,
            string memory _location,
            uint _price) public {

        uint _soldCount = 0;
        products[productCount] = Product(
            payable(msg.sender),
            _name, _image, _description, _location,
            _price, _soldCount
        );

        productCount++;
    }

    function readProductCount() view public returns (uint) {
        return productCount;
    }

    function buyProduct(uint _index) public payable {
        require(ERC20Interface(cUSDTokenaddress).transferFrom(msg.sender, products[_index].owner, products[_index].price), "Transaction Failed");
        products[_index].soldCount++;
    }

}