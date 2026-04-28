# Jenkins Integration Guide for Chess Application

## 📋 What Has Been Created

Your chess application is now ready for Jenkins integration with the following files:

### Pipeline Configuration
- **Jenkinsfile** - Main pipeline script with 7 stages
- **JENKINS_SETUP.md** - Detailed setup and configuration guide

### Docker Support
- **Dockerfile** - For Node.js server container
- **frontend/Dockerfile** - For frontend Nginx container
- **docker-compose.yml** - Orchestrates all services

### Project Configuration
- **package.json** - Node.js dependencies and scripts
- **.gitignore** - Git exclusions
- **.dockerignore** - Docker build exclusions

---

## 🚀 Quick Start Guide

### Step 1: Prepare Your Jenkins Instance

Ensure Jenkins has these plugins installed:
```
- Pipeline
- NodeJS Plugin
- Maven Plugin
- Docker Pipeline (optional but recommended)
- Git Plugin
```

### Step 2: Configure Jenkins Tools

Go to **Manage Jenkins → Configure System** and set up:

1. **NodeJS**
   - Name: `NodeJS`
   - Installation: Select automatic installation (v16 or higher)

2. **Maven**
   - Name: `Maven`
   - Installation: Select automatic installation (v3.8+)

3. **JDK**
   - Ensure Java is installed and configured

### Step 3: Create Pipeline Job

1. Click **New Item**
2. Enter Name: `Chess-App-Pipeline`
3. Select **Pipeline** → Click **OK**
4. Under **Pipeline** section:
   - **Definition**: Select "Pipeline script from SCM"
   - **SCM**: Select Git
   - **Repository URL**: Your repository URL
   - **Script Path**: `Jenkinsfile`
5. Click **Save**

### Step 4: Run the Pipeline

1. Click **Build Now**
2. Monitor progress in **Console Output**
3. After success, check **Artifacts** for built JAR and frontend

---

## 📊 Pipeline Stages Breakdown

| Stage | Purpose | Tools |
|-------|---------|-------|
| Checkout | Clone source code | Git |
| Build Backend | Compile Java backend | Maven |
| Build Frontend | Build React frontend | Node.js/NPM |
| Unit Tests | Run backend tests | Maven/JUnit |
| Code Quality | Static analysis | (Ready for SonarQube) |
| Build Docker Images | Create container images | Docker |
| Archive Artifacts | Save build outputs | Jenkins |

---

## 🔧 Customization Examples

### Enable SonarQube Analysis

Edit Jenkinsfile, update the "Code Quality Check" stage:

```groovy
stage('Code Quality Check') {
    steps {
        dir('backend') {
            withSonarQubeEnv('SonarQube') {
                sh 'mvn clean verify sonar:sonar'
            }
        }
    }
}
```

### Add Deployment Stage

Add this new stage before the closing brace:

```groovy
stage('Deploy') {
    when {
        branch 'main'  // Only deploy from main branch
    }
    steps {
        echo "Deploying Chess Application..."
        sh '''
            docker-compose -f docker-compose.yml down
            docker-compose -f docker-compose.yml up -d
        '''
    }
}
```

### Push Docker Images to Registry

Update the "Build Docker Images" stage:

```groovy
sh '''
    docker tag chess-app-backend:${BUILD_NUMBER} your-registry.azurecr.io/chess-app-backend:${BUILD_NUMBER}
    docker tag chess-app-backend:${BUILD_NUMBER} your-registry.azurecr.io/chess-app-backend:latest
    docker push your-registry.azurecr.io/chess-app-backend:${BUILD_NUMBER}
    docker push your-registry.azurecr.io/chess-app-backend:latest
'''
```

### Add Slack Notifications

Add to the `post` section:

```groovy
success {
    slackSend(
        color: 'good',
        message: "Chess App Pipeline #${BUILD_NUMBER} completed successfully!"
    )
}
failure {
    slackSend(
        color: 'danger',
        message: "Chess App Pipeline #${BUILD_NUMBER} failed. Check logs!"
    )
}
```

---

## 📁 Directory Structure After Integration

```
chess-app/
├── Jenkinsfile                 ← Pipeline configuration
├── Dockerfile                  ← Node.js server container
├── docker-compose.yml          ← Docker orchestration
├── package.json                ← Node dependencies
├── .gitignore                  ← Git exclusions
├── .dockerignore               ← Docker exclusions
├── JENKINS_SETUP.md            ← Setup instructions
├── README.md                   ← This file
├── server.js                   ← Express server
├── backend/
│   ├── Dockerfile              ← Spring Boot container
│   ├── pom.xml                 ← Maven configuration
│   └── src/
├── frontend/
│   ├── Dockerfile              ← Nginx container
│   ├── index.html
│   └── ...
└── nginx/
    └── nginx.conf
```

---

## ✅ Verification Checklist

After setting up Jenkins:

- [ ] Jenkins job created and named "Chess-App-Pipeline"
- [ ] Git repository URL configured correctly
- [ ] NodeJS plugin installed and configured
- [ ] Maven plugin installed and configured
- [ ] First build triggered and completed successfully
- [ ] Artifacts are archived
- [ ] Docker images built successfully
- [ ] No errors in pipeline execution

---

## 🐛 Troubleshooting

### Build fails at "Build Backend"
```
Solution: Check Maven installation in Jenkins
- Go to Manage Jenkins → Configure System
- Verify Maven tool is configured
- Ensure backend/pom.xml exists
```

### Build fails at "Build Frontend"
```
Solution: Check Node.js installation
- Verify NodeJS plugin is installed
- Check NodeJS tool is configured
- Ensure package.json is valid
```

### Docker build fails
```
Solution: Verify Docker daemon
- Ensure Docker is installed on Jenkins agent
- Check Jenkins user has Docker permissions: 
  sudo usermod -aG docker jenkins
```

### Pipeline times out
```
Solution: Increase timeout or optimize builds
- Remove unnecessary dependencies
- Use Docker for consistent environments
- Cache Maven/NPM dependencies
```

---

## 🎯 Next Steps

1. **Commit Changes**: Push all new files to your repository
2. **Create Job**: Set up Jenkins job as described above
3. **First Build**: Trigger initial build to verify configuration
4. **Optimize**: Add deployment, notifications, and additional stages
5. **Monitor**: Set up alerts and build notifications

---

## 📞 Support Resources

- Jenkins Documentation: https://www.jenkins.io/doc/
- Jenkins Pipeline Syntax: https://www.jenkins.io/doc/book/pipeline/
- Docker Documentation: https://docs.docker.com/
- Maven Documentation: https://maven.apache.org/guides/
- Node.js & NPM: https://nodejs.org/en/docs/

---

**Ready to integrate with Jenkins! 🚀**
