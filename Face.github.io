<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Nexus | Secure Terminal</title>
    <style>
        :root {
            --neon: #00ff41;
            --purple: #a349a4;
            --glass: rgba(255, 255, 255, 0.05);
            --bg: #0a0a0b;
            --danger: #ff4444;
        }

        body {
            background: var(--bg);
            color: #e0e0e0;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* --- UI COMPONENTS --- */
        .container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            z-index: 10;
        }

        .glass-card {
            background: var(--glass);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            text-align: center;
        }

        h2 { color: var(--neon); letter-spacing: 3px; text-transform: uppercase; margin-bottom: 25px; }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            background: rgba(0,0,0,0.3);
            border: 1px solid #444;
            border-radius: 8px;
            color: var(--neon);
            box-sizing: border-box;
            outline: none;
        }

        .btn {
            width: 100%;
            padding: 14px;
            background: var(--purple);
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
            transition: 0.3s;
        }

        .btn:hover { filter: brightness(1.2); box-shadow: 0 0 15px var(--purple); }

        /* --- DASHBOARD --- */
        #dashboard {
            display: none;
            max-width: 1100px;
            width: 90%;
            padding: 40px 0;
            animation: fadeIn 0.5s ease;
        }

        .project-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .project-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 12px;
            padding: 25px;
            transition: 0.3s;
            cursor: pointer;
        }

        .project-card:hover { 
            border-color: var(--neon); 
            background: rgba(0, 255, 65, 0.05);
            transform: translateY(-5px);
        }

        .tag { font-size: 0.7rem; background: var(--purple); padding: 3px 8px; border-radius: 4px; }

        /* --- MODAL FOR PROJECT DETAILS --- */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.95);
            z-index: 100;
            overflow-y: auto;
            padding: 40px 20px;
        }

        .modal-content {
            background: #111;
            max-width: 900px;
            margin: auto;
            padding: 40px;
            border-radius: 12px;
            border: 1px solid var(--neon);
            line-height: 1.7;
        }

        .close-btn { color: var(--danger); float: right; cursor: pointer; font-size: 1.2rem; font-weight: bold; }

        .hidden { display: none !important; }
        
        table { width: 100%; border-collapse: collapse; margin: 20px 0; font-size: 0.9rem; }
        th, td { border: 1px solid #333; padding: 12px; text-align: left; }
        th { background: rgba(0,255,65,0.1); color: var(--neon); }

        .code-block {
            background: #000;
            padding: 15px;
            border-left: 3px solid var(--neon);
            font-family: monospace;
            overflow-x: auto;
            margin: 15px 0;
            color: #88ff88;
        }

        h3 { color: var(--neon); border-bottom: 1px solid #333; padding-bottom: 10px; margin-top: 30px; }
    </style>
</head>
<body>

    <div id="login-section" class="container">
        <div class="glass-card">
            <h2>Nexus Terminal</h2>
            <input type="text" id="username" placeholder="USER ID">
            <input type="password" id="password" placeholder="ACCESS KEY">
            <button class="btn" onclick="showOTP()">INITIALIZE</button>
        </div>
    </div>

    <div id="otp-section" class="container hidden">
        <div class="glass-card">
            <h2>MFA Verification</h2>
            <p style="font-size: 0.8rem; color: #888;">Generated Dynamic Token:</p>
            <h3 id="generated-otp" style="color: var(--neon); letter-spacing: 5px;">####</h3>
            <input type="text" id="otp-input" placeholder="Enter Token">
            <button class="btn" onclick="validateOTP()">VERIFY ACCESS</button>
        </div>
    </div>

    <div id="dashboard">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <h2 style="margin:0;">Project Submission Hub</h2>
            <button onclick="location.reload()" class="btn" style="width: auto; padding: 8px 15px; margin: 0; background: #333;">System Logout</button>
        </div>
        
        <div class="project-grid">
            <div class="project-card" onclick="openProject('face-lock')">
                <span class="tag">Flagship: Biometrics</span>
                <h3>Smart Face-Lock System</h3>
                <p>AI-driven security using Convolutional Neural Networks (CNN) for real-time authentication.</p>
                <div style="font-size: 0.8rem; color: var(--neon);">[View Technical Report]</div>
            </div>

            <div class="project-card">
                <span class="tag">AI & Robotics</span>
                <h3>Neural Pathfinding</h3>
                <p>Warehouse automation drone navigating using SLAM and A* pathfinding algorithms.</p>
            </div>

            <div class="project-card">
                <span class="tag">IoT</span>
                <h3>Smart Grid Monitor</h3>
                <p>Real-time energy consumption tracking with automated load balancing via MQTT.</p>
            </div>
        </div>
    </div>

    <div id="project-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">EXIT TERMINAL [X]</span>
            <h1>Face Authentication Door Lock System</h1>
            <p><i>Submission for: Final Year Engineering Project</i></p>
            
            <h3>1. Abstract</h3>
            <p>Traditional locking systems are prone to theft or physical bypass. This project integrates <b>Deep Metric Learning</b> with hardware actuation to create a robust, keyless entry system. Using a Raspberry Pi and a high-def camera, the system detects, aligns, and verifies faces against a pre-authorized database with a response time of < 1.5 seconds.</p>

            <h3>2. Technical Framework (Architecture)</h3>
            
            <p>The system follows a Pipeline-based architecture:</p>
            <ul>
                <li><b>Face Detection:</b> Using Histogram of Oriented Gradients (HOG).</li>
                <li><b>Feature Extraction:</b> Utilizing the <b>ResNet-34</b> architecture to generate a 128-dimensional vector representing the face.</li>
                <li><b>Classification:</b> A Linear SVM (Support Vector Machine) determines the identity.</li>
            </ul>

            <h3>3. Mathematical Foundations</h3>
            <p>To ensure high precision, we utilize <b>Triplet Loss</b> during training, ensuring that the distance between a live image and the database image is minimized.</p>
            <div class="code-block">
                L = max(d(a, p) - d(a, n) + margin, 0)
            </div>
            <p>Where <i>a</i> is the anchor (database), <i>p</i> is positive (authorized user), and <i>n</i> is negative (intruder).</p>

            <h3>4. Logic & Flow Control</h3>
            
            <p>The software logic includes a "Fail-Safe" mechanism. If the system fails to recognize a face 3 times, an alert is sent via Telegram API to the administrator.</p>

            <h3>5. Hardware Interface & Schematic</h3>
            
            <table>
                <tr><th>Component</th><th>Specification</th><th>Role</th></tr>
                <tr><td>Raspberry Pi</td><td>Model 4B (4GB RAM)</td><td>AI Inference Engine</td></tr>
                <tr><td>Relay</td><td>5V Single Channel</td><td>Switching 12V DC Load</td></tr>
                <tr><td>Solenoid</td><td>12V DC Electromagnetic</td><td>Deadbolt Actuator</td></tr>
                <tr><td>Camera</td><td>8MP Sony IMX219</td><td>Visual Sensing</td></tr>
            </table>

            <h3>6. Core Python Implementation</h3>
            <div class="code-block">
# Triggering the Solenoid Lock via GPIO
import RPi.GPIO as GPIO
import time

LOCK_PIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(LOCK_PIN, GPIO.OUT)

def unlock_door():
    GPIO.output(LOCK_PIN, GPIO.HIGH) # Open lock
    time.sleep(5)                   # Wait 5 seconds
    GPIO.output(LOCK_PIN, GPIO.LOW)  # Relock
            </div>
        </div>
    </div>

    <script>
        let currentOTP = "";

        function showOTP() {
            if(document.getElementById('username').value === "") return alert("Enter User ID");
            currentOTP = Math.floor(1000 + Math.random() * 9000).toString();
            document.getElementById('generated-otp').innerText = currentOTP;
            document.getElementById('login-section').classList.add('hidden');
            document.getElementById('otp-section').classList.remove('hidden');
        }

        function validateOTP() {
            if(document.getElementById('otp-input').value === currentOTP) {
                document.getElementById('otp-section').classList.add('hidden');
                document.getElementById('dashboard').style.display = 'block';
                document.body.style.alignItems = 'flex-start';
            } else {
                alert("ACCESS DENIED: Invalid Security Token");
            }
        }

        function openProject(id) {
            if(id === 'face-lock') document.getElementById('project-modal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('project-modal').style.display = 'none';
        }
    </script>
</body>
</html>
