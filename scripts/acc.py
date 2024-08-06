from ape_accounts import import_account_from_mnemonic

def main():
    alias = "my-account"
    passphrase = "my$ecurePassphrase"
    mnemonic = "test test test test test test test test test test test junk"

    account = import_account_from_mnemonic(alias, passphrase, mnemonic)

    print(f'Your imported account address is: {account.address}')

if __name__ == "__main__":
    main()