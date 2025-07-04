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

### 3. Push to repository

```bash
git push origin main
```
> When pushed to repository a workflow will test the changes and make a new artifact.

---

### 4. download the artifact via CLI

```bash
gh auth
gh run download --repo ronthesoul/ronstaller --name installer-$build-number
chmod +x installer_$build-number
./installer_$build-number
```

> Change $build-number to the required artifact number for example installer installer-7.

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
