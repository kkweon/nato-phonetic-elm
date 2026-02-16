#!/usr/bin/env node
/**
 * Generate PNG favicons from SVG
 * Run: node generate-favicons.js
 * Requires: npm install sharp (if not already installed)
 */

const fs = require('fs');
const path = require('path');

const svgContent = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect width="100" height="100" rx="20" fill="#132dae"/>
  <text x="50" y="72" font-family="Arial, sans-serif" font-size="60" font-weight="900" fill="white" text-anchor="middle">N</text>
</svg>`;

const sizes = [
  { size: 16, name: 'favicon-16x16.png' },
  { size: 32, name: 'favicon-32x32.png' },
  { size: 180, name: 'apple-touch-icon.png' },
  { size: 512, name: 'og-image.png' }
];

async function generateFavicons() {
  try {
    const sharp = require('sharp');
    const docsDir = path.join(__dirname, 'docs');

    for (const { size, name } of sizes) {
      const buffer = await sharp(Buffer.from(svgContent))
        .resize(size, size)
        .png()
        .toBuffer();

      fs.writeFileSync(path.join(docsDir, name), buffer);
      console.log(`✓ Generated ${name} (${size}x${size})`);
    }

    console.log('\n✓ All favicons generated successfully!');
  } catch (error) {
    if (error.code === 'MODULE_NOT_FOUND') {
      console.error('\n❌ Error: sharp module not found');
      console.error('\nPlease install sharp first:');
      console.error('  npm install sharp\n');
      console.error('Then run this script again:');
      console.error('  node generate-favicons.js\n');
    } else {
      console.error('Error generating favicons:', error);
    }
    process.exit(1);
  }
}

generateFavicons();
