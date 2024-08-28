// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AreaCalculator {
    function calculateSquare(uint256 side) public pure returns (uint256) {
        return side ** 2;
    }

    function calculateRectangleArea(uint256 length, uint256 width) public pure returns (uint256) {
        return length * width;
    }

    function calculateTriangleArea(uint256 base, uint256 heigth) public pure returns (uint256) {
        return (base * heigth) / 2;
    }
}
