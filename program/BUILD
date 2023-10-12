BARE_METAL_RISCV64_CONSTRAINTS = [
    "//platform:bare_metal",
    "@platforms//cpu:riscv64",
]

cc_binary(
    name = "program",
    srcs = [
        "program.c",
        "boot.S",
    ],
    additional_linker_inputs = [
        "link_script.ld",
    ],
    linkopts = ["-Wl,-T $(location :link_script.ld)"],
    target_compatible_with = BARE_METAL_RISCV64_CONSTRAINTS,
)
