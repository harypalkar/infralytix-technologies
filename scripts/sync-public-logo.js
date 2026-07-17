const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");
const cssSrc = path.join(root, "src/main/resources/static/css");
const cssDest = path.join(root, "public/css");

fs.copyFileSync(path.join(cssSrc, "style.css"), path.join(cssDest, "style.css"));
fs.copyFileSync(path.join(cssSrc, "responsive.css"), path.join(cssDest, "responsive.css"));

const publicDir = path.join(root, "public");
const files = fs.readdirSync(publicDir).filter((f) => f.endsWith(".html"));

for (const f of files) {
  const filePath = path.join(publicDir, f);
  let html = fs.readFileSync(filePath, "utf8");
  html = html.replace(/logo-icon\.png\?v=\d+/g, "logo-icon.png?v=3");
  html = html.replace(/<span class="navbar-logo-ring"><\/span>\s*/g, "");
  fs.writeFileSync(filePath, html);
}

console.log("Synced CSS and updated", files.length, "HTML files");
