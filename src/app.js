 // app.js

const updateBalanceBtn = document.getElementById('updateBalanceBtn');
const moneyInBtn = document.getElementById('moneyInBtn');
const moneyOutBtn = document.getElementById('moneyOutBtn');

updateBalanceBtn.addEventListener('click', async () => {
    const creditAlert = document.getElementById('creditAlert').value;
    const debitAlert = document.getElementById('debitAlert').value;

    const response = await fetch('/update_balance', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ creditAlert, debitAlert })
    });

    const data = await response.json();
    alert(data.status);
    updateAlertsDisplay();
});

moneyInBtn.addEventListener('click', async () => {
    const amount = document.getElementById('moneyInAmount').value;

    const response = await fetch('/money_in', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ amount })
    });

    const data = await response.json();
    alert(data.status);
    updateAlertsDisplay();
});

moneyOutBtn.addEventListener('click', async () => {
    const amount = document.getElementById('moneyOutAmount').value;

    const response = await fetch('/money_out', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ amount })
    });

    const data = await response.json();
    alert(data.status);
    updateAlertsDisplay();
});

async function updateAlertsDisplay() {
    const response = await fetch('/get_alerts');
    const data = await response.json();

    document.getElementById('creditAlertDisplay').innerText = data.creditAlert;
    document.getElementById('debitAlertDisplay').innerText = data.debitAlert;
}

// Initial load
updateAlertsDisplay();

