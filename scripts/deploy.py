from ape import project

def main():
    contract = project.TestToken.deployments[0]
    print(contract)