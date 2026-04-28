# Jenkins Setup Quick Reference

## 🚀 30-Second Setup

### Step 1: Jenkins Configuration
```
Manage Jenkins → Global Tool Configuration

Maven:
  Name: (default)
  ✓ Install automatically
  Version: 3.8.x or latest

NodeJS:
  Name: (default)
  ✓ Install automatically
  Version: 16 LTS or latest

Java/JDK:
  Name: (default)
  ✓ Install automatically
  Version: 11 or latest
```

### Step 2: Create Pipeline Job
```
New Item
├─ Name: Chess-App-Pipeline
├─ Type: Pipeline
└─ OK

Configure
├─ Definition: Pipeline script from SCM
├─ SCM: Git
├─ Repository URL: <your-repo-url>
├─ Script Path: Jenkinsfile
├─ Build Triggers: (optional)
└─ Save
```

### Step 3: Build
```
Click: Build Now
Monitor: Console Output
Result: SUCCESS ✅
```

---

## 📦 What Gets Built

```
chess-app/
├─ backend/
│  └─ target/
│     └─ chess-app-backend-1.0.0.jar ← Backend executable
├─ build/
│  ├─ index.html ← Frontend
│  ├─ css/
│  ├─ js/
│  └─ assets/
└─ docker-compose.yml ← Deploy with this
```

---

## ⚙️ Pipeline Stages (In Order)

1. **Checkout** - Clone repo
2. **Print Environment** - Show versions
3. **Build Backend** - Maven compile (Java)
4. **Build Frontend** - Copy HTML/CSS/JS
5. **Unit Tests** - Run tests
6. **Build Docker** - Create container
7. **Archive** - Save artifacts

---

## 🔧 If Something Fails

| Error | Fix |
|-------|-----|
| `mvn: not found` | Install Maven plugin |
| `npm: not found` | Install NodeJS plugin |
| `docker: not found` | Install Docker on agent |
| `BUILD FAILED` | Check console for error details |
| `Artifacts not found` | Verify build outputs exist |

---

## 📊 Expected Times

- **Checkout**: 5-10 seconds
- **Build Backend**: 30-60 seconds (first time longer)
- **Build Frontend**: 10-20 seconds
- **Unit Tests**: 10-30 seconds
- **Docker Build**: 20-40 seconds
- **Archive**: 5 seconds

**Total**: ~2-4 minutes (first time), 1-2 minutes (subsequent)

---

## ✅ Success Criteria

- [x] No compilation errors
- [x] No artifact errors
- [x] Docker image created
- [x] All artifacts archived
- [x] Build log shows "SUCCESS"

---

## 🎯 Next: Deployment

After first successful build:
1. Download artifacts from Jenkins
2. Deploy using docker-compose
3. Access at: http://localhost:3000

```bash
docker-compose -f docker-compose.yml up -d
```

---

**Your Chess App is ready for Jenkins! 🚀**
