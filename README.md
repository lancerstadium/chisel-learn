
## 配置环境

Setup Scala:

```
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
sudo chmod +x cs
./cs setup
```


Start a Chisel example:

```
git clone https://github.com/schoeberl/chisel-examples.git

cd chisel-examples
cd hello-world
sbt run
```