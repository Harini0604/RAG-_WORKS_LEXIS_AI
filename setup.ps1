# LEXIS AI Setup Script
# This script automates the setup of the LEXIS AI project

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "LEXIS AI - Project Setup Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check Node.js installation
Write-Host "[1/6] Checking Node.js installation..." -ForegroundColor Yellow
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Node.js is not installed. Please install Node.js v18+" -ForegroundColor Red
    exit 1
}
$nodeVersion = node -v
Write-Host "✓ Node.js version: $nodeVersion" -ForegroundColor Green
Write-Host ""

# Check if .env exists in server directory
Write-Host "[2/6] Setting up Server Environment..." -ForegroundColor Yellow
if (-Not (Test-Path ".\server\.env")) {
    Write-Host "Creating .env file in server directory..."
    $envContent = @"
PORT=5000
MONGODB_URI=mongodb://localhost:27017/lexis-ai
OPENAI_API_KEY=sk-your-actual-openai-key-here
JWT_SECRET=your-secret-key-for-jwt
LOG_LEVEL=info
"@
    Set-Content -Path ".\server\.env" -Value $envContent
    Write-Host "✓ .env file created (update OPENAI_API_KEY with your actual key)" -ForegroundColor Green
} else {
    Write-Host "✓ .env file already exists" -ForegroundColor Green
}
Write-Host ""

# Install server dependencies
Write-Host "[3/6] Installing Server Dependencies..." -ForegroundColor Yellow
Push-Location ".\server"
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to install server dependencies" -ForegroundColor Red
    Pop-Location
    exit 1
}
Write-Host "✓ Server dependencies installed" -ForegroundColor Green
Pop-Location
Write-Host ""

# Install client dependencies
Write-Host "[4/6] Installing Client Dependencies..." -ForegroundColor Yellow
Push-Location ".\client"
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to install client dependencies" -ForegroundColor Red
    Pop-Location
    exit 1
}
Write-Host "✓ Client dependencies installed" -ForegroundColor Green
Pop-Location
Write-Host ""

# Run server tests
Write-Host "[5/6] Running Tests..." -ForegroundColor Yellow
Push-Location ".\server"
npm test -- --passWithNoTests
Write-Host "✓ Tests completed" -ForegroundColor Green
Pop-Location
Write-Host ""

# Success message
Write-Host "[6/6] Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "NEXT STEPS:" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Update your OpenAI API Key:"
Write-Host "   Edit .\server\.env and add your actual OPENAI_API_KEY"
Write-Host ""
Write-Host "2. Start MongoDB (if using local):"
Write-Host "   mongod"
Write-Host ""
Write-Host "3. Start the Backend Server (in a new terminal):"
Write-Host "   cd server"
Write-Host "   npm run dev"
Write-Host ""
Write-Host "4. Start the Frontend (in another new terminal):"
Write-Host "   cd client"
Write-Host "   npm run dev"
Write-Host ""
Write-Host "5. Access the application:"
Write-Host "   Backend: http://localhost:5000"
Write-Host "   Frontend: http://localhost:5173"
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Documentation: See README.md for complete API documentation" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
