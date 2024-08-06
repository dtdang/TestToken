from ape_safe import multisend
from ape_tokens import tokens
from ape import accounts

def main():
    bal0 = accounts.load("0-balance")

    breakpoint()
    dai = tokens["YFI"]
    vault = tokens["YFII"]
    amount = dai.balanceOf(bal0)

    txn = multisend.Transaction()
    txn.add(dai.approve, vault, amount)
    txn.add(vault.deposit, amount)

    txn(sender=bal0)

if __name__ == "__main__":
    main()