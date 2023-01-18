# k8s playground

Creating a local k8s cluster to experiment with

## Table of Contents

- [k8s playground](#k8s-playground)
  - [Table of Contents](#table-of-contents)
  - [VirtualBox](#virtualbox)
  - [Specs](#specs)
  - [Ubuntu Autoinstall Config](#ubuntu-autoinstall-config)
  - [Makefile](#makefile)

## VirtualBox

To start your experiments with k8s you need to install locally [VirtualBox](https://www.virtualbox.org/)

Follow the [Download](https://www.virtualbox.org/wiki/Linux_Downloads) section

## Specs

**Each node** will have:

- 10GB HDD
- 1GB RAM
- 1 CPU Core
- 2 Network Cards
- 16MB RAM for VMSVGA

## Ubuntu Autoinstall Config

- [Ubuntu Autoconfig](https://ubuntu.com/server/docs/install/autoinstall-reference)

## Makefile

The bellow command will try to **create VirtualBox instances** and **configure** them.

The default number of Nodes is 4

```bash
make cluster
```

The bellow command will download if doesnt exists **ubuntu server 22.04** and will try to **install** it on specific node.

```bash
make ubuntu 1..N
```
