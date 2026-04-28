# 🚀 Chess Application - Single Command Deployment Guide

## Overview

Your chess application can now be deployed in **a single command** using either:
1. **Jenkins Pipeline** (Recommended for CI/CD)
2. **Deployment Scripts** (Quick local deployment)
3. **Docker Compose** (Manual control)

---

## ⚡ Method 1: One-Command Local Deployment

### Windows
```batch
cd d:\DevOps Learning\Jenkins\Jenkins Project\chess-app
deploy.bat
```

### Linux/Mac
```bash
cd /path/to/chess-app
bash deploy.sh
```

**What it does:**
- ✅ Builds Java backend (Maven)
- ✅ Builds frontend (NPM)
- ✅ Creates Docker image
- ✅ Stops old containers
- ✅ Starts new containers
- ✅ Health checks
- ✅ Displays access URLs

**Time:** ~3-5 minutes (first time), ~1-2 minutes (subsequent)

---

## 🔧 Method 2: Jenkins Pipeline (Recommended for CI/CD)

### Setup
1. Create Jenkins job
2. Set up as **Pipeline** type
3. Configure Git repository
4. Set **Script Path**: `Jenkinsfile`
5. Click **Build Now**

### What the Pipeline Does
```
Checkout Code
    ↓
Build Backend (Maven)
    ↓
Build Frontend (NPM)
    ↓
Run Tests
    ↓
Build Docker Image
    ↓
Deploy to Server ← Starts docker-compose
    ↓
Health Checks ← Verifies everything is running
    ↓
SUCCESS ✓ → Application is LIVE!
```

### Pipeline Stages
| Stage | Time | Output |
|-------|------|--------|
| Checkout | 5s | Source code ready |
| Print Environment | 3s | Tools available |
| Build Backend | 45s | JAR created |
| Build Frontend | 15s | Build directory created |
| Unit Tests | 20s | Tests passed |
| Build Docker | 30s | Image created |
| Deploy | 15s | Containers running |
| Health Check | 10s | Services verified |

**Total Time:** ~2-3 minutes

---

## 🐳 Method 3: Manual Docker Compose Deployment

If you prefer more control:

```bash
cd chess-app

# Stop old deployment
docker-compose down

# Build images
docker build -t chess-app-backend:latest ./backend

# Start everything
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

---

## 📊 What Gets Deployed

### Frontend (Nginx)
- **Port:** 3000
- **Container:** chess-frontend
- **Files:** Served from `build/` directory
- **Access:** http://localhost:3000

### Backend (Spring Boot)
- **Port:** 8080
- **Container:** chess-backend
- **API:** http://localhost:8080/api/health
- **Database:** In-memory (no persistence yet)

### Network
- **Name:** chess-network
- **Type:** Bridge
- **Purpose:** Containers can communicate

---

## ✅ Health Check Endpoints

After deployment, verify everything is running:

```bash
# Backend health
curl http://localhost:8080/api/health

# Backend version
curl http://localhost:8080/api/version

# Frontend
curl http://localhost:3000
```

---

## 📁 Key Files for Deployment

```
chess-app/
├── Jenkinsfile              ← Jenkins pipeline (root level)
├── deploy.sh                ← Linux/Mac deployment script
├── deploy.bat               ← Windows deployment script
├── docker-compose.yml       ← Container orchestration
├── Dockerfile               ← Node.js container
├── backend/
│   ├── Dockerfile           ← Spring Boot container
│   ├── pom.xml              ← Maven config
│   └── src/                 ← Java source
├── frontend/
│   ├── index.html
│   ├── css/
│   └── js/
├── build/                   ← Generated during npm build
│   ├── index.html
│   ├── css/
│   └── js/
└── nginx/
    └── nginx.conf           ← Nginx web server config
```

---

## 🔄 Typical Workflow

### Development
1. Make code changes
2. Commit to Git
3. Jenkins automatically triggers
4. Watch pipeline execute
5. Application deployed in ~3 minutes
6. Test at http://localhost:3000

### Manual Quick Deploy
```bash
cd chess-app
deploy.bat  # or deploy.sh
```

### Stop Service
```bash
cd chess-app
docker-compose down
```

### Restart Service
```bash
cd chess-app
docker-compose restart
```

---

## 🐛 Troubleshooting

### Deployment Fails at "Build Backend"
```
❌ mvn: command not found
✓ Solution: Install Maven locally or via Jenkins tools
```

### Deployment Fails at "Build Frontend"
```
❌ npm: command not found
✓ Solution: Install Node.js locally
```

### Containers Won't Start
```
❌ Error: port 8080 already in use
✓ Solution 1: Kill existing process
  - Windows: netstat -ano | findstr :8080
  - Linux: lsof -i :8080
✓ Solution 2: Change port in docker-compose.yml
```

### Services Not Healthy
```
❌ Cannot connect to http://localhost:8080
✓ Check container logs: docker logs chess-backend
✓ Check Docker running: docker ps
✓ Wait longer for startup
```

### Jenkins Job Fails
```
✓ Check console output for error
✓ Ensure Git repository configured correctly
✓ Verify Jenkins has Docker access
✓ Check Docker daemon is running
```

---

## 📈 Performance

### Build Times (First Run)
- Maven compile: ~45 seconds
- NPM install: ~30 seconds
- Docker build: ~20 seconds
- **Total: ~2-3 minutes**

### Build Times (Subsequent)
- Maven: ~30 seconds (faster with cache)
- NPM: ~5 seconds (dependencies cached)
- Docker: ~5 seconds (layers cached)
- **Total: ~40-60 seconds**

### Deployment Time
- Container startup: ~5-10 seconds
- Health checks: ~10 seconds
- **Total: ~15-20 seconds**

---

## 🎯 Quick Reference

### Linux/Mac
```bash
# Deploy everything
bash chess-app/deploy.sh

# View logs
cd chess-app && docker-compose logs -f

# Stop
cd chess-app && docker-compose down
```

### Windows
```batch
# Deploy everything
chess-app\deploy.bat

# View logs
cd chess-app && docker-compose logs -f

# Stop
cd chess-app && docker-compose down
```

### Jenkins
1. Click "Build Now"
2. Watch the 8 stages execute
3. Application live in ~3 minutes

---

## 🚀 Next Steps

### Option A: Use Jenkins (Recommended)
- Set up Jenkins job pointing to this repo
- Every commit triggers automatic deployment
- No manual steps needed

### Option B: Local Scripts
- Use `deploy.bat` or `deploy.sh`
- Fastest for development
- Good for testing

### Option C: Docker Compose
- Most control
- Good for advanced configuration
- Manual step-by-step

---

## 📞 Support

### Common Commands
```bash
# Full deployment
deploy.bat

# Check status
docker-compose ps

# View logs
docker-compose logs chess-backend

# Restart
docker-compose restart

# Stop everything
docker-compose down

# Clean everything
docker-compose down -v
```

### Port Mapping
- **Frontend:** localhost:3000 → nginx:80
- **Backend:** localhost:8080 → spring:8080
- **Node Server:** localhost:5000 → node:5000

### Health Endpoints
- Backend: http://localhost:8080/api/health
- Frontend: http://localhost:3000
- Status: docker-compose ps

---

**🎉 Your Chess Application is Ready for Single-Go Deployment!**

Choose your preferred method above and get started! 🚀
