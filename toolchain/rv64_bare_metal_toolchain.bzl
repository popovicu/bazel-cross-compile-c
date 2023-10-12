load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "tool_path", "flag_group", "flag_set")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    toolchain_tools = ["gcc", "ld", "ar", "cpp", "gcov", "nm", "objdump", "strip"]
    tool_paths = [tool_path(name = tool, path = "/usr/bin/riscv64-linux-gnu-{}".format(tool)) for tool in toolchain_tools]

    ASSEMBLE_ACTIONS = [
        ACTION_NAMES.assemble,
        ACTION_NAMES.preprocess_assemble,
    ]
    
    COMPILE_ACTIONS = [
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.c_compile
    ]
    
    ASSEMBLE_AND_COMPILE_ACTIONS = ASSEMBLE_ACTIONS + COMPILE_ACTIONS

    arch_abi = feature(
        name = "arch_and_abi",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ASSEMBLE_AND_COMPILE_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = ["-march=rv64i", "-mabi=lp64"],
                    ),
                ],
            )
        ],
    )

    LINK_ACTIONS = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_static_library,
    ]
    
    link_static_no_stdlib = feature(
        name = "link_static_no_stdlib",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = LINK_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = ["-Wl,--no-dynamic-linker", "-static", "-nostdlib"],
                    ),
                ],
            )
        ],
    )

    no_build_id = feature(
        name = "no_build_id",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = LINK_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = ["-Wl,--build-id=none"],
                    ),
                ],
            )
        ],
    )
    
    features = [arch_abi, link_static_no_stdlib, no_build_id]
    
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "riscv64",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = [
            "/usr/riscv64-linux-gnu/include/",
            "/usr/lib/gcc-cross/riscv64-linux-gnu/10/include/",
        ],
        features = features,
    )

rv64_bare_metal_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
