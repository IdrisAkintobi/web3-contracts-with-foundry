// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Test, console } from "forge-std/Test.sol";
import { AreaCalculator } from "../src/AreaCalculator.sol";

contract AreaCalculatorTest is Test {
    AreaCalculator public areaCalculator;

    function setUp() public {
        areaCalculator = new AreaCalculator();
    }

    function test_CalculateSquare() public view {
        uint256 expected = areaCalculator.calculateSquare(4);
        assertEq(expected, 16, "Square area calculation failed");
    }

    function test_CalculateRectangleArea() public view {
        uint256 expected = areaCalculator.calculateRectangleArea(2, 4);
        assertEq(expected, 8, "Rectangle area calculation failed");
    }

    function test_CalculateTriangleArea() public view {
        uint256 expected = areaCalculator.calculateTriangleArea(3, 4);
        assertEq(expected, 6, "Trangle area calculation failed");
    }
}
