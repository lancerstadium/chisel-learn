
# Chisel-Learn

目的：帮助快速入门`chisel`语言，熟悉 FPGA 相关知识，敏捷开发 RISCV-CPU 。

```
 .o88b. db   db d888888b .d8888. d88888b db             db      d88888b  .d8b.  d8888b. d8b   db 
d8P  Y8 88   88   `88'   88'  YP 88'     88             88      88'     d8' `8b 88  `8D 888o  88 
8P      88ooo88    88    `8bo.   88ooooo 88             88      88ooooo 88ooo88 88oobY' 88V8o 88 
8b      88~~~88    88      `Y8b. 88~~~~~ 88      C8888D 88      88~~~~~ 88~~~88 88`8b   88 V8o88 
Y8b  d8 88   88   .88.   db   8D 88.     88booo.        88booo. 88.     88   88 88 `88. 88  V888 
 `Y88P' YP   YP Y888888P `8888Y' Y88888P Y88888P        Y88888P Y88888P YP   YP 88   YD VP   V8P 
                                                   
```


## 项目目录

- [x] demo01：Hello World
- [x] demo02：Counter
- [x] demo03：BCD De/Encoder
- [x] demo04：Absract Ticker & Test
- [x] demo05：BubbleFIFO
- [x] demo06：BufferFIFO
- [x] demo07：OtherFIFOs
- [x] demo08：Simple RiscV32 CPU Design
- [ ] demo09：Complex RiscV64 CPU Design (NutShell)



## 配置环境

Setup Scala:

```
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
sudo chmod +x cs
./cs setup
```


Start a Chisel original example:

```
git clone https://github.com/schoeberl/chisel-examples.git

cd chisel-examples
cd hello-world
sbt run
```

Start with this repo:

```
git clone https://github.com/lancerstadium/chisel-learn.git

cd chisel-learn/demo01
sbt run

```