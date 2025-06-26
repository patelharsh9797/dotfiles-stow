# 🛠️ Tunnel Manager with Gum

This script provides a **simple** and **interactive** way to **manage** SSH **tunnels** using **Charmbracelet's** **Gum** for a beautiful and intuitive terminal experience.

---

## 📦 Prerequisites

- **Bash** (v5.0+)
- **SSH** client
- **Gum** (install via **Homebrew** or **Go**)

### 🔧 Installing Gum

```bash
brew install gum  # MacOS / Linux (with Homebrew)
```

or

```bash
go install github.com/charmbracelet/gum@latest  # Go
```

---

## 📂 Directory Structure

```
.
├── tunnel.sh    # The main script
└── .env         # Optional environment file
```

---

## 🗃️ .env File Format

You can optionally define your environment variables in a **`.env`** file:

```plaintext
SERVER_USER=root
SERVER_IP=192.168.1.100
PORTS=5433:5432,3000:3000,9999:9999
REMOTE_LOCAL=0.0.0.0
```

---

## 🚀 Usage

### 🆕 Start Tunnels

```bash
./tunnel.sh --start
```

or **interactively**:

```bash
./tunnel.sh
```

### 🛑 Stop Tunnels

```bash
./tunnel.sh --stop
```

### 🟥 Force Stop All Tunnels

```bash
./tunnel.sh --force-stop
```

### 📊 Check Tunnel Status

```bash
./tunnel.sh --status
```

### ⚙️ Command-Line Options

- **`--start`** - Start tunnels
- **`--stop`** - Stop tunnels
- **`--force-stop`** - Force Stop All tunnels
- **`--status`** - Show tunnel status
- **`--ip <IP>`** - Specify server IP
- **`--user <username>`** - Specify server username
- **`--ports <ports>`** - Specify port pairs (comma-separated)
- **`--remote <address>`** - Set remote address (default is **0.0.0.0**)

### 🔄 Example Commands

Start tunnels with custom **IP** and **user**:

```bash
./tunnel.sh --start --ip 128.0.0.1 --user root --ports 5433:5432,3000:3000
```

Stop tunnels without prompting:

```bash
./tunnel.sh --stop --ip 128.0.0.1 --user root --ports 5433:5432,3000:3000
```

Check tunnel status:

```bash
./tunnel.sh --status
```

---

## 🛠️ Features

- **Interactive prompts** for **user**, **IP**, **ports**, and **remote address**
- **Action menu** for starting, stopping, and checking tunnel status
- **Color-coded** status messages
- **Graceful exit** on invalid input

---

## 🤖 Example .env File

Create a **`.env`** file to **skip** interactive prompts:

```plaintext
SERVER_USER=root
SERVER_IP=128.0.0.1
PORTS=5433:5432,3000:3000,9999:9999
REMOTE_LOCAL=0.0.0.0
```

---

## 🛑 Stopping Tunnels

The script **automatically** finds and **kills** matching SSH processes to **stop** tunnels.

---

## 📝 Notes

- The **`.env`** file **overrides** any **manual** inputs unless command-line arguments are used.
- Make sure your **SSH key** is **added** to the **agent** to avoid **password** prompts.

---

## 💡 Tips

- Use **`nohup`** or **`tmux`** for **persistent** tunnels
- Use **`sudo`** if you encounter **"Operation not permitted"** errors

---

## 🚀 Future Improvements

- **Health checks** for tunnels
- **Auto-reconnect** on failure
- **Logging** for connection history

---

Enjoy seamless SSH tunneling with **gum**! 🚀
