load(":rv64_bare_metal_toolchain.bzl", "rv64_bare_metal_toolchain_config")

filegroup(name = "empty")

rv64_bare_metal_toolchain_config(
    name = "rv64_bare_metal_config"
);

cc_toolchain(
    name = "rv64_bare_metal_toolchain",
    toolchain_identifier = "local",
    toolchain_config = ":rv64_bare_metal_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = False,
)

toolchain(
    name = "riscv64_bare_metal_toolchain_from_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "//platform:bare_metal",
        "@platforms//cpu:riscv64",
    ],
    toolchain = ":rv64_bare_metal_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
