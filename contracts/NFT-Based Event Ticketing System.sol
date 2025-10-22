// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title NFT-Based Event Ticketing System
/// @notice A simple contract to issue event tickets as NFT
contract Project is ERC721URIStorage, Ownable {
    uint256 public ticketCounter;
    uint256 public maxTickets;
    uint256 public ticketPrice;
    string public eventName;
    address public eventOrganizer;

    constructor(
        string memory _eventName,
        uint256 _maxTickets,
        uint256 _ticketPrice
    ) ERC721("EventTicket", "ETK") Ownable(msg.sender) {
        eventName = _eventName;
        maxTickets = _maxTickets;
        ticketPrice = _ticketPrice;
        eventOrganizer = msg.sender;
        ticketCounter = 0;
    }

    /// @notice Mint a new ticket (NFT) for the event
    function buyTicket(string memory tokenURI) external payable {
        require(ticketCounter < maxTickets, "All tickets sold");
        require(msg.value == ticketPrice, "Incorrect payment amount");

        ticketCounter++;
        uint256 newTicketId = ticketCounter;

        _mint(msg.sender, newTicketId);
        _setTokenURI(newTicketId, tokenURI);
    }

    /// @notice Organizer can withdraw funds from ticket sale
    function withdrawFunds() external onlyOwner {
        payable(eventOrganizer).transfer(address(this).balance);
    }

    /// @notice Get event details
    function getEventDetails()
        external
        view
        returns (string memory, uint256, uint256, uint256, address)
    {
        return (
            eventName,
            maxTickets,
            ticketPrice,
            ticketCounter,
            eventOrganizer
        );
    }
}






