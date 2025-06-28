# 🐳 Ronstaller

**Ronstaller** is a customizable installer framework that lets you bundle your own Docker-based app into a portable Linux installer.

---

## 📦 How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/ronthesoul/ronstaller.git
cd ronstaller
```

---

### 2. Add Your Application

- Put your application files or Docker image into the `application/` folder.
- Edit the `application/Dockerfile` to fit your app’s needs.

---

### 3. Build the Installer

```bash
makeself --tar-extra "--exclude=.git --exclude=.github" . installer.run "My App Installer" ./install.sh
```

> This creates a self-extracting installer script called `installer.run`.

---

### 4. Run the Installer

```bash
chmod +x installer.run
./installer.run
```

---

## 🛠 Customize

- **Edit `application/Dockerfile`** to control how your app is built and run.
- **Place `.deb` files inside `dependencies/`** to install system packages before your app runs.
- **Edit `install.sh`** to customize the overall installation logic.

---

## 📁 Project Structure

```
ronstaller/
├── application/        # Your app files or Docker image
│   └── Dockerfile      # Modify this for your app
├── dependencies/       # Optional .deb packages
├── install.sh          # Main installation script
├── .github/            # CI workflows
└── README.md
```

---

## 📌 Important

Make sure to:

- Replace the contents of `application/` with your app.
- Edit placeholders in `install.sh` and `Dockerfile` to match your app's actual executable or services.
- Test the output `installer.run` before distributing.

---

## 👤 Author

Made with 🛠 by Ron Negrov
