import ape
from requests import Response

from ape_etherscan.client import ContractClient, ClientFactory
from ape_etherscan.types import EtherscanInstance

def explorer():
    network = ape.networks.get_ecosystem("ethereum").get_network("sepolia")
    explorer = network.explorer
    return explorer

def main():
    client_factory = ClientFactory(
        EtherscanInstance(
            ecosystem_name="ethereum",
            network_name="sepolia",
            uri="https://ethereum-sepolia-rpc.publicnode.com",
            api_uri="https://api-sepolia.etherscan.io/api"
        )
    )
    contract_address = "0x528e7c77b8f3001b512e8bf305b03cea420951cd "
    client = client_factory.get_contract_client(contract_address)
    data = client.get_creation_data()
    print(data)
    
if __name__ == "__main__":
    main()