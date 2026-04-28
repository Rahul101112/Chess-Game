# Chess Application - Jenkins Pipeline Documentation

## Overview
This document explains how to integrate the Chess Application with Jenkins for automated CI/CD.

## Prerequisites
- Jenkins server with the following plugins installed:
  - Pipeline plugin
  - NodeJS plugin
  - Maven plugin
  - Docker plugin (for Docker builds)

## Pipeline Stages

### 1. Checkout
Clones the repository from your version control system.

### 2. Build Backend
- Builds the Spring Boot Java backend using Maven
- Generates JAR file in `backend/target/`

### 3. Build Frontend
- Installs Node.js dependencies
- Builds React frontend to `build/` directory

### 4. Unit Tests - Backend
- Runs Maven tests for the Java backend

### 5. Code Quality Check
- Placeholder for SonarQube integration
- Can add static code analysis here

### 6. Build Docker Images
- Creates Docker image for the backend
- Uses the Dockerfile in the `backend/` directory

### 7. Archive Artifacts
- Archives the built JAR and frontend build directory
- Makes them available for download

## Setup Instructions

### Step 1: Create Jenkins Job
1. Go to Jenkins Dashboard
2. Click "New Item"
3. Enter job name: `Chess-App-Pipeline`
4. Select "Pipeline"
5. Click OK

### Step 2: Configure Pipeline
1. Under "Pipeline", select "Pipeline script from SCM"
2. Set SCM to your Git repository
3. Set Script Path to `Jenkinsfile` (the file in chess-app root)

### Step 3: Configure Agent Requirements
- Ensure Jenkins agent has:
  - Node.js installed (NodeJS plugin configured)
  - Maven installed (Maven plugin configured)
  - Docker installed (for Docker builds)
  - Java installed

### Step 4: Build the Job
1. Click "Build Now"
2. Monitor the progress in the build console
3. Artifacts will be archived after successful build

## Environment Variables
The pipeline uses:
- `NODEJS_HOME`: Node.js installation path
- `JAVA_HOME`: Java installation path
- `MAVEN_HOME`: Maven installation path
- `BUILD_NUMBER`: Jenkins build number (auto-generated)
- `WORKSPACE`: Build workspace path
- `NODE_NAME`: Jenkins agent name

## Customization

### To add deployment stage:
Add the following to your Jenkinsfile:
```groovy
stage('Deploy') {
    steps {
        // Add your deployment commands here
        // Example: docker run, kubectl apply, etc.
    }
}
```

### To integrate SonarQube:
Add to the "Code Quality Check" stage:
```groovy
dir('backend') {
    sh 'mvn sonar:sonar'
}
```

### To push Docker images to registry:
Add to "Build Docker Images" stage:
```groovy
sh 'docker tag chess-app-backend:${BUILD_NUMBER} your-registry/chess-app:${BUILD_NUMBER}'
sh 'docker push your-registry/chess-app:${BUILD_NUMBER}'
```

## Troubleshooting

**Build fails at "Build Backend":**
- Ensure Maven is installed and configured in Jenkins
- Check that Java version matches Maven requirements

**Build fails at "Build Frontend":**
- Ensure Node.js is installed and configured in Jenkins
- Check package.json exists and is valid

**Docker build fails:**
- Ensure Docker daemon is running on Jenkins agent
- Verify Dockerfile exists in backend directory

## Next Steps
1. Commit the Jenkinsfile to your repository
2. Create the Jenkins job as described above
3. Trigger the first build
4. Monitor and adjust as needed
