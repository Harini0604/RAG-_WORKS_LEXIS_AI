# LEXIS AI - Complete Terminal Commands Guide

## Quick Reference

This file contains all the terminal commands you need to set up and run the LEXIS AI project.

---

## Prerequisites Check

```powershell
# Check Node.js version (must be v18+)
node -v
npm -v

# Check if MongoDB is installed (optional for demo)
mongod --version
```

---

## 1. Initial Setup (One-Time)

### Option A: Automatic Setup (Recommended)
```powershell
# Navigate to project directory
cd c:\Users\Ranjith\Downloads\LEXIS\ AI

# Run the setup script
.\setup.ps1
```

### Option B: Manual Setup

```powershell
# Navigate to project
cd c:\Users\Ranjith\Downloads\LEXIS\ AI

# Install server dependencies
cd server
npm install

# Create .env file with environment variables
# Windows PowerShell:
$envContent = @"
PORT=5000
MONGODB_URI=mongodb://localhost:27017/lexis-ai
OPENAI_API_KEY=sk-your-actual-openai-key-here
JWT_SECRET=your-secret-key-for-jwt
LOG_LEVEL=info
"@
Set-Content -Path ".env" -Value $envContent

# Or using Command Prompt:
# echo PORT=5000 > .env
# echo MONGODB_URI=mongodb://localhost:27017/lexis-ai >> .env
# echo OPENAI_API_KEY=sk-your-key-here >> .env
# echo JWT_SECRET=your-secret >> .env

# Install client dependencies
cd ../client
npm install
```

---

## 2. Running the Project

### Terminal 1: Start MongoDB (Optional but Recommended)
```powershell
# If MongoDB is installed locally
mongod

# Or use MongoDB Atlas (update MONGODB_URI in .env)
# Skip this if using cloud database
```

### Terminal 2: Start Backend Server
```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Development mode with auto-reload
npm run dev

# OR Production mode
npm start
```

**Expected Output:**
```
════════════════════════════════════════════════════════
  🚀 LEXIS AI Server Running
════════════════════════════════════════════════════════
  Server:    http://localhost:5000
  Health:    http://localhost:5000/health
  API:       http://localhost:5000/api
  Logs:      ./logs/
════════════════════════════════════════════════════════
```

### Terminal 3: Start Frontend Server
```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\client

# Development server
npm run dev
```

**Expected Output:**
```
  VITE v5.4.0  ready in 234 ms

  ➜  Local:   http://localhost:5173/
  ➜  press h to show help
```

---

## 3. Accessing the Application

Once both servers are running:

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:5000
- **Health Check**: http://localhost:5000/health
- **Logs**: `server/logs/combined.log` and `server/logs/error.log`

---

## 4. Testing

```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Run all tests
npm test

# Run tests with coverage
npm test -- --coverage

# Run specific test file
npm test guardrails.test.js

# Run tests in watch mode
npm test -- --watch
```

---

## 5. Seeding Demo Data

```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Seed MongoDB with sample cases
npm run seed
```

---

## 6. Building for Production

```powershell
# Build the frontend
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\client
npm run build

# Preview production build locally
npm run preview

# Output: dist/ folder contains optimized files for deployment
```

---

## 7. Linting & Code Quality

```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\client

# Lint code
npm run lint

# Fix linting issues automatically
npm run lint -- --fix
```

---

## 8. Environment Configuration

### Update OpenAI API Key

```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Edit the .env file
# Option 1: Using Notepad
notepad .env

# Option 2: Using PowerShell
(Get-Content .env) -replace 'OPENAI_API_KEY=.*', 'OPENAI_API_KEY=sk-your-actual-key' | Set-Content .env

# Verify the change
Get-Content .env | Select-String OPENAI_API_KEY
```

### Configure MongoDB

```powershell
# Option 1: Use local MongoDB
# Start MongoDB: mongod
# Keep MONGODB_URI=mongodb://localhost:27017/lexis-ai in .env

# Option 2: Use MongoDB Atlas (Cloud)
# 1. Sign up at https://www.mongodb.com/cloud/atlas
# 2. Create a cluster
# 3. Get connection string from Atlas
# 4. Update .env:
# MONGODB_URI=mongodb+srv://user:password@cluster.mongodb.net/lexis-ai
```

---

## 9. Troubleshooting Commands

### Check if ports are in use
```powershell
# Check port 5000 (backend)
netstat -ano | findstr :5000

# Check port 5173 (frontend)
netstat -ano | findstr :5173

# Kill process using port 5000
Stop-Process -Id <PID> -Force

# Or change ports in .env and vite.config.js
```

### View Logs
```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Real-time log monitoring
Get-Content logs/combined.log -Wait

# View error logs
Get-Content logs/error.log

# Count log entries
(Get-Content logs/combined.log | Measure-Object -Line).Lines
```

### Clear Logs
```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Clear combined logs
Clear-Content logs/combined.log

# Clear error logs
Clear-Content logs/error.log
```

### Verify Dependencies
```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI\server

# Check installed packages
npm list

# Check for outdated packages
npm outdated

# Update all packages (careful!)
npm update
```

---

## 10. Full Reset (Clean Installation)

```powershell
cd c:\Users\Ranjith\Downloads\LEXIS\ AI

# Remove node_modules and lock files
Remove-Item -Recurse -Force server/node_modules
Remove-Item -Recurse -Force client/node_modules
Remove-Item server/package-lock.json
Remove-Item client/package-lock.json

# Reinstall everything
cd server
npm install
cd ../client
npm install

# Clear cache if needed
npm cache clean --force
```

---

## 11. Testing Individual API Endpoints

### Health Check
```powershell
# PowerShell
Invoke-WebRequest -Uri "http://localhost:5000/health" -Method Get | ConvertFrom-Json

# Or using curl (if installed)
curl http://localhost:5000/health
```

### Get All Cases
```powershell
Invoke-WebRequest -Uri "http://localhost:5000/api/cases" -Method Get | ConvertFrom-Json
```

### Query RAG
```powershell
$body = @{
    caseId = "1"
    question = "Was the defendant present at the scene?"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:5000/api/rag/query" `
    -Method Post `
    -Headers @{"Content-Type"="application/json"} `
    -Body $body | ConvertFrom-Json
```

### Detect Contradictions
```powershell
$body = @{
    textA = "Defendant was at location A at 10pm"
    textB = "Defendant was at location B at 10pm"
    docA = "statement1.pdf"
    docB = "statement2.pdf"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:5000/api/rag/detect-contradictions" `
    -Method Post `
    -Headers @{"Content-Type"="application/json"} `
    -Body $body | ConvertFrom-Json
```

---

## 12. Deployment Commands (Optional)

### Build Docker Image
```powershell
# Create Dockerfile first
docker build -t lexis-ai .
docker run -p 5000:5000 -e OPENAI_API_KEY=sk-... lexis-ai
```

### Deploy to Heroku
```powershell
heroku create lexis-ai
git push heroku main
heroku logs --tail
```

---

## 13. Development Workflow

```powershell
# Terminal 1: MongoDB
mongod

# Terminal 2: Backend (with auto-reload)
cd server && npm run dev

# Terminal 3: Frontend (with hot reload)
cd client && npm run dev

# Terminal 4: Run tests in watch mode
cd server && npm test -- --watch

# Terminal 5: Monitor logs
cd server && Get-Content logs/combined.log -Wait
```

---

## 14. Performance Monitoring

```powershell
# Check Node.js memory usage
Get-Process | Where-Object {$_.Name -like "*node*"}

# Monitor CPU usage during requests
# Use Task Manager or:
Get-Process "node" | Select-Object Name, CPU, Memory, Handles
```

---

## Quick Start Cheat Sheet

```powershell
# Complete setup and run in one session:
cd c:\Users\Ranjith\Downloads\LEXIS\ AI
.\setup.ps1  # Wait for completion

# In Terminal 1:
cd server && npm run dev

# In Terminal 2:
cd client && npm run dev

# In Terminal 3:
cd server && npm test

# Access: http://localhost:5173
```

---

## Environment Variables Reference

| Variable | Default | Purpose |
|----------|---------|---------|
| PORT | 5000 | Backend server port |
| MONGODB_URI | mongodb://localhost:27017/lexis-ai | Database connection |
| OPENAI_API_KEY | Required | GPT-4o API access (get from openai.com) |
| JWT_SECRET | supersecret | JWT token signing secret |
| LOG_LEVEL | info | Logging verbosity (error, warn, info, debug) |
| NODE_ENV | development | Environment mode |

---

## Support Resources

1. **README.md**: Full documentation
2. **API Documentation**: See README.md API section
3. **Logs**: `server/logs/combined.log` for debugging
4. **Tests**: `server/tests/*.test.js` for usage examples
5. **GitHub Issues**: Report problems (when ready to submit)

---

## Submission Checklist

Before submitting:
- [ ] Run `npm test` - all tests pass
- [ ] No errors in `server/logs/error.log`
- [ ] README.md is complete and clear
- [ ] API endpoints respond correctly
- [ ] Environment variables configured
- [ ] GitHub repository is public
- [ ] All files committed and pushed

---

**Generated**: April 27, 2026  
**Project**: LEXIS AI v1.0.0  
**Status**: Ready for Production
