# k8s playground

Creating a local K8S cluster to experiment with and help me pass CKA Exames

## Table of Contents

- [k8s playground](#k8s-playground)
  - [Table of Contents](#table-of-contents)
  - [VirtualBox](#virtualbox)
  - [Specs](#specs)
  - [Ubuntu Autoinstall Config](#ubuntu-autoinstall-config)
  - [Makefile](#makefile)
  - [Useful links](#useful-links)

## VirtualBox

To start your experiments with k8s you need to install locally [VirtualBox](https://www.virtualbox.org/)

Follow the [Download](https://www.virtualbox.org/wiki/Linux_Downloads) section

## Specs

**Each node** will have:

- 10GB HDD
- 8GB RAM
- 2 CPU Core
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
make ubuntu node=1..N
```

## Useful links

- https://www.virtualbox.org/manual/ch08.html
- https://gist.github.com/estorgio/0c76e29c0439e683caca694f338d4003
- https://askubuntu.com/questions/481559/how-to-automatically-mount-a-folder-and-change-ownership-from-root-in-virtualbox
- https://ubuntu.com/server/docs/install/autoinstall
- https://dustinspecker.com/posts/ubuntu-autoinstallation-virtualbox/
- https://gist.github.com/bitsandbooks/6e73ec61a44d9e17e1c21b3b8a0a9d4c
- https://manintheit.org/posts/automation/ubuntu-autoinstall/

## Traingings for Free

- https://www.cncf.io/certification/training/