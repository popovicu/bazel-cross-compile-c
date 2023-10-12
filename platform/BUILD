constraint_value(
    name = "bare_metal",
    constraint_setting = "@platforms//os",
    visibility = ["//visibility:public"],
)

platform(
    name = "riscv64_bare_metal",
    constraint_values = [
        ":bare_metal",
        "@platforms//cpu:riscv64",
    ],
)
