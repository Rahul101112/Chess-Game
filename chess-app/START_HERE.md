# ⚡ Quick Start - Deploy Chess App in 30 Seconds

## The Absolute Simplest Way

### Windows
```
1. Open PowerShell/Command Prompt
2. Navigate to chess-app folder:
   cd "d:\DevOps Learning\Jenkins\Jenkins Project\chess-app"
3. Run:
   deploy.bat
4. Wait ~3 minutes
5. Visit http://localhost:3000
```

### Linux/Mac
```
1. Open Terminal
2. Navigate to chess-app folder:
   cd /path/to/chess-app
3. Run:
   bash deploy.sh
4. Wait ~3 minutes
5. Visit http://localhost:3000
```

---

## That's It! 🎉

Your chess app will be:
- ✅ Built
- ✅ Packaged
- ✅ Containerized
- ✅ Running
- ✅ Accessible at http://localhost:3000

---

## What's Running?

```
Frontend (Nginx)      →  http://localhost:3000
Backend (Spring Boot) →  http://localhost:8080
Network               →  All containers connected
```

---

## Stop Everything
```
cd chess-app
docker-compose down
```

---

## View Logs
```
cd chess-app
docker-compose logs -f
```

---

## Using Jenkins Instead?

1. Jenkins → New Item → Pipeline
2. Configure Git Repository
3. Set Script Path: `Jenkinsfile`
4. Click "Build Now"
5. App deploys automatically in 2-3 minutes

---

## If Something Goes Wrong

Check logs:
```
docker-compose logs
```

Stop everything:
```
docker-compose down
```

Try again:
```
deploy.bat
```

---

**That's all you need to know! Your chess app is production-ready. 🚀**
