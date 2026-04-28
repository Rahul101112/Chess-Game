const chessboard = document.getElementById('chessboard');
const themeSelector = document.getElementById('themeSelector');
const startBtn = document.getElementById('startBtn');
const timeDisplay = document.getElementById('timeDisplay');
let timerInterval;
let timeLeft = 600; // 10 minutes in seconds

// Theme Switcher
themeSelector.addEventListener('change', (e) => {
    document.body.setAttribute('data-theme', e.target.value);
});

// Timer Logic
function startTimer() {
    clearInterval(timerInterval);
    timerInterval = setInterval(() => {
        if(timeLeft <= 0) {
            clearInterval(timerInterval);
            alert("Time's up!");
            return;
        }
        timeLeft--;
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        timeDisplay.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    }, 1000);
}

// API Interactions
startBtn.addEventListener('click', async () => {
    const side = document.getElementById('sideSelector').value;
    const response = await fetch(`http://localhost/api/game/start?playerSide=${side}`, {
        method: 'POST'
    });
    const fen = await response.text();
    renderBoard(fen);
    startTimer();
});

function renderBoard(fenString) {
    chessboard.innerHTML = '';
    // Simplify board rendering for example purposes. 
    // You would parse the FEN string to place SVG images in the correct squares here.
    let isLight = true;
    for (let i = 0; i < 64; i++) {
        const square = document.createElement('div');
        square.classList.add('square');
        square.classList.add(isLight ? 'light' : 'dark');
        
        // Add drag/drop event listeners here to send API calls to /api/game/move
        
        chessboard.appendChild(square);
        isLight = !isLight;
        if ((i + 1) % 8 === 0) isLight = !isLight; // Offset for next row
    }
}