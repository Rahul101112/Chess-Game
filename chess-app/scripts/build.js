#!/usr/bin/env node
/**
 * Build script for Chess Application
 * Copies frontend files (HTML/CSS/JS) to build directory
 */

const fs = require('fs');
const path = require('path');

const BUILD_DIR = path.join(__dirname, '..', 'build');
const FRONTEND_DIR = path.join(__dirname, '..', 'frontend');
const PUBLIC_DIR = path.join(__dirname, '..', 'public');

// Create build directory
if (!fs.existsSync(BUILD_DIR)) {
    fs.mkdirSync(BUILD_DIR, { recursive: true });
}

// Recursive copy function
function copyDir(src, dest) {
    if (!fs.existsSync(dest)) {
        fs.mkdirSync(dest, { recursive: true });
    }

    const files = fs.readdirSync(src);

    files.forEach(file => {
        const srcFile = path.join(src, file);
        const destFile = path.join(dest, file);

        if (fs.statSync(srcFile).isDirectory()) {
            copyDir(srcFile, destFile);
        } else {
            fs.copyFileSync(srcFile, destFile);
            console.log(`Copied: ${srcFile} → ${destFile}`);
        }
    });
}

try {
    console.log('Building Chess Application Frontend...');
    console.log(`Source: ${FRONTEND_DIR}`);
    console.log(`Build: ${BUILD_DIR}`);

    // Copy frontend directory
    if (fs.existsSync(FRONTEND_DIR)) {
        copyDir(FRONTEND_DIR, BUILD_DIR);
        console.log('✓ Frontend copied successfully');
    } else {
        console.warn('⚠ Frontend directory not found');
    }

    // Copy public assets
    if (fs.existsSync(PUBLIC_DIR)) {
        copyDir(PUBLIC_DIR, BUILD_DIR);
        console.log('✓ Public assets copied successfully');
    }

    console.log('✓ Build completed successfully!');
    console.log(`Output directory: ${BUILD_DIR}`);
} catch (error) {
    console.error('✗ Build failed:', error.message);
    process.exit(1);
}
