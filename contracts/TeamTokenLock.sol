pragma solidity ^0.8.0;

import "./AllerSafe.sol";

contract TeamTokenLock {
    

    // ERC20 basic token contract being held
    AllerSafe private immutable _token;

    // beneficiary of tokens after they are released
    address private immutable _beneficiary;

    // timestamp when token release is enabled
    uint256 private immutable _releaseTime;

    constructor(
        AllerSafe token_,
        address beneficiary_,
        uint256 releaseTime_
    ) {
        require(releaseTime_ > block.timestamp, "TeamTokenLock: release time is before current time");
        _token = token_;
        _beneficiary = beneficiary_;
        _releaseTime = releaseTime_;
    }

    /**
     * @return the token being held.
     */
    function token() public view virtual returns (AllerSafe) {
        return _token;
    }

    /**
     * @return the beneficiary of the tokens.
     */
    function beneficiary() public view virtual returns (address) {
        return _beneficiary;
    }

    /**
     * @return the time when the tokens are released.
     */
    function releaseTime() public view virtual returns (uint256) {
        return _releaseTime;
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function release() public virtual {
        require(block.timestamp >= releaseTime(), "TeamTokenLock: current time is before release time");

        uint256 amount = token().balanceOf(address(this));
        require(amount > 0, "TeamTokenLock: no tokens to release");

        
    }
}
