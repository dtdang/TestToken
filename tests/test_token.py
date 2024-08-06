def test_initial(new_token, owner, payer):
    assert new_token.name() == "Test Token"
    assert new_token.symbol() == "TEST"
    assert new_token.decimals() == 18
    assert new_token.totalSupply() == 1000
    assert new_token.balanceOf(owner) == 1000
    assert new_token.allowance(owner, payer) == 0

def test_transfer(new_token, payer, owner):
    new_token.transfer(payer, 10, sender=owner, show_trace=True)
    new_token.balanceOf(payer, show_trace=True)
    assert new_token.balanceOf(payer) == 10

def test_approve(new_token, payer, owner):
    new_token.approve(payer, 10, sender=owner, show_trace=True)
    assert new_token.allowance(owner, payer) == 10

def test_transferfrom(new_token, payer, owner):
    new_token.approve(owner, 10, sender=owner)
    new_token.transferFrom(owner, payer, 10, sender=owner)
    assert new_token.balanceOf(payer) == 10
