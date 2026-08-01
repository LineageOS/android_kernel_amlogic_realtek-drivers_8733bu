load("//build/kernel/kleaf:kernel.bzl", "kernel_module")

def rtl8733bu_module(name, kernel_build, deps = None):
    kernel_module(
        name = name,
        srcs = ["//vendor/amlogic/realtek-drivers/8733bu:rtl8733bu_srcs"],
        makefile = ["//vendor/amlogic/realtek-drivers/8733bu:Makefile"],
        deps = deps,
        outs = ["8733bu.ko"],
        kernel_build = kernel_build,
    )
