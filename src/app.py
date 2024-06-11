 # app.py

from flask import Flask, request, jsonify
from web3 import Web3

app = Flask(__name__)

# Connect to local Ethereum node
w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))

# Contract ABI and address (replace with actual values)
contract_address = '0xYourContractAddress'
contract_abi = [...]  # Add the ABI here

contract = w3.eth.contract(address=contract_address, abi=contract_abi)
owner = w3.eth.accounts[0]

@app.route('/update_balance', methods=['POST'])
def update_balance():
    data = request.get_json()
    credit_alert = data['creditAlert']
    debit_alert = data['debitAlert']

    tx_hash = contract.functions.updateBalance(credit_alert, debit_alert).transact({'from': owner})
    w3.eth.wait_for_transaction_receipt(tx_hash)

    return jsonify({'status': 'Balance updated'})

@app.route('/money_in', methods=['POST'])
def money_in():
    data = request.get_json()
    amount = data['amount']

    tx_hash = contract.functions.moneyIn(amount).transact({'from': owner})
    w3.eth.wait_for_transaction_receipt(tx_hash)

    return jsonify({'status': 'Money added'})

@app.route('/money_out', methods=['POST'])
def money_out():
    data = request.get_json()
    amount = data['amount']

    tx_hash = contract.functions.moneyOut(amount).transact({'from': owner})
    w3.eth.wait_for_transaction_receipt(tx_hash)

    return jsonify({'status': 'Money subtracted'})

@app.route('/get_alerts', methods=['GET'])
def get_alerts():
    credit_alert, debit_alert = contract.functions.getAlert().call()
    return jsonify({'creditAlert': credit_alert, 'debitAlert': debit_alert})

if __name__ == '__main__':
    app.run(debug=True)

