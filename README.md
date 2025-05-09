# 🖧 Networking Lab Sample Code for Students (in C)

This repository contains sample C programs for practicing core networking concepts such as socket programming, client-server communication, and basic protocols. It is intended for students learning networking through practical lab sessions.

## 📌 Prerequisites

Before getting started, make sure you have:

- **GCC (GNU C Compiler)** installed  
  - Linux: Usually pre-installed or install using `sudo apt install build-essential`
  - Windows: Use [MinGW](http://www.mingw.org/) or [WSL](https://docs.microsoft.com/en-us/windows/wsl/)
- **PuTTY** (for Windows users) – to emulate terminals or connect to remote Linux servers: https://www.putty.org/

---

## ⚙️ Compile Programs Using GCC

Open your terminal or PuTTY session and compile the desired program using:

```bash
gcc filename.c -o output_name
```

For example:

```bash
gcc tcps.c -o tcps
gcc tcpc.c -o tcpc
```

---

## ▶️ Run the Server and Client

In two separate terminals (or PuTTY sessions):

1. **Start the server**:
   ```bash
   ./tcps 8080
   ```

2. **Start the client** (in another terminal):
   ```bash
   ./tcpc 127.0.0.1 8080
   ```

> Replace `127.0.0.1` with the server’s IP if using different machines.

---

## 📂 Programs Included

| File(s)            | Description |
|--------------------|-------------|
| `tcps.c`, `tcpc.c` | TCP client-server communication using sockets |
| `udps.c`, `udpc.c` | UDP client-server example (connectionless communication) |
| `ftps.c`, `ftpc.c` | Simple file transfer using sockets |
| `sw.c`, `sw2.c`    | Stop-and-Wait protocol simulation |
| `dv.c`, `dv2.c`    | Distance Vector Routing protocol simulation |
| `cc.c`, `cc2.c`    | Basic socket connection example |

Each pair of programs represents a client-server model where one program listens or serves (`s`), and the other connects or consumes (`c`).

---

## 💡 Using PuTTY (for Windows Users)

- Install PuTTY: https://www.putty.org/
- Open two PuTTY sessions to simulate two terminals
- Use one for the server and one for the client
- Works great when connecting to a Linux machine or using WSL on Windows

---

## 🤝 Contributing

Contributions are welcome! You can:

- Add new networking programs or protocol simulations
- Improve existing code or add comments
- Fix bugs or errors

To contribute:

1. Fork this repository
2. Create a new branch
3. Commit your changes
4. Open a Pull Request

---


Made with ❤️ for students learning networking through C programming.


#BY SOURAV
