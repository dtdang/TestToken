# @version 0.3.10

from vyper.interfaces import ERC20

implements: ERC20

# ERC20 Token Metadata
name: public(String[20])
symbol: public(String[5])
decimals: public(uint8)

# ERC20 State Variables
totalSupply: public(uint256)
balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])

# Events
event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    amount: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    amount: uint256

owner: public(address)


@external
def __init__(_name: String[20], _symbol: String[5], _decimals: uint8, _totalSupply: uint256, _initSupply: uint256):
    self.name = _name
    self.symbol = _symbol
    self.decimals = _decimals
    self.owner = msg.sender
    self.totalSupply = _totalSupply
    self.balanceOf[msg.sender] = _initSupply

    log Transfer(empty(address), msg.sender, _initSupply)

@external
def transfer(receiver: address, amount: uint256) -> bool:
    assert receiver != empty(address)
    assert receiver != self

    sender_balance: uint256 = self.balanceOf[msg.sender]
    assert sender_balance >= amount, "Insufficient balance"

    self.balanceOf[msg.sender] = sender_balance - amount
    self.balanceOf[receiver] += amount

    log Transfer(msg.sender, receiver, amount)
    return True


@external
def transferFrom(sender: address, receiver: address, amount: uint256) -> bool:
    assert sender != empty(address)
    assert sender != self
    assert receiver != empty(address)
    assert receiver != self

    allowance_sender_spender: uint256 = self.allowance[sender][msg.sender]
    assert allowance_sender_spender >= amount, "Insufficient allowance"

    sender_balance: uint256 = self.balanceOf[sender]
    assert sender_balance >= amount, "Insufficient balance"

    self.allowance[sender][msg.sender] = allowance_sender_spender - amount
    self.balanceOf[sender] = sender_balance - amount
    self.balanceOf[receiver] += amount

    log Transfer(sender, receiver, amount)
    return True


@external
def approve(spender: address, amount: uint256) -> bool:
    self.allowance[msg.sender][spender] = amount

    log Approval(msg.sender, spender, amount)
    return True


@external
def burn(amount: uint256) -> bool:
    sender_balance: uint256 = self.balanceOf[msg.sender]
    assert sender_balance >= amount, "Insufficient balance"

    self.balanceOf[msg.sender] = sender_balance - amount
    self.totalSupply -= amount

    log Transfer(msg.sender, empty(address), amount)

    return True


@external
def mint(receiver: address, amount: uint256) -> bool:
    assert msg.sender == self.owner, "Access is denied."
    assert receiver != empty(address)
    assert receiver != self

    self.totalSupply += amount
    self.balanceOf[receiver] += amount

    log Transfer(empty(address), receiver, amount)

    return True