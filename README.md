# Bazel C/C++ cross-compile example: RISC-V bare metal

This repository illustrates how to cross-compile C/C++ programs with Bazel through the toolchain and platforms mechanism. The concrete example used is building for bare metal RISC-V machine.

**This repo is meant to accompany the article at http://popovicu.com/posts/cross-compiling-c-with-bazel**

## Hermeticity

The rules are not fully hermetic and they assume that your GCC tools for RISC-V are at `/usr/bin/riscv64-linux-gnu-...`. If the path prefix is something different on your system, make the relevant change in `toolchain/rv64_bare_metal_toolchain.bzl` file. This path is hardcoded for simplicity.

## Building

To build, run the following command:

```
bazel build -s --platforms=//platform:riscv64_bare_metal //program
```

The `-s` flag ensures that you see the individual steps of the build (you may need to `bazel clean` first if there is some existing cache, so you can see the whole build from scratch).

## Running on QEMU

Once built, the ELF file can be run on QEMU:

```
qemu-system-riscv64 -machine virt -bios bazel-bin/program/program -nographic
```

Output:

```
Hello world! Writing to UART from bare metal.
```
