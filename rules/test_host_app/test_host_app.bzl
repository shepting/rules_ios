"""
Generates test host ios_application targets for each supported version

A consumer of `rules_ios` can optionally load the `generate_test_host_apps` symbol
and pass in additional attributes to be set in all `ios_application` rules
"""

load("//rules:app.bzl", "ios_application")

DEFAULT_MINIMUM_OS_VERSION_LIST = [
    "9.3",
    "10.0",
    "11.0",
    "12.0",
    "12.2",
    "12.4",
    "13.0",
    "13.2",
    "13.6",
    "14.0",
    "14.1",
    "14.2",
    "14.3",
    "15.0",
]

def generate_test_host_apps(versions = None, **kwargs):
    if not versions or len(versions) == 0:
        versions = DEFAULT_MINIMUM_OS_VERSION_LIST
    for version in versions:
        generate_test_host_app_with_minimum_os_version(version, **kwargs)

def generate_test_host_app_with_minimum_os_version(version, **kwargs):
    ios_application(
        name = "iOS-{}-AppHost".format(version),
        srcs = ["@build_bazel_rules_ios//rules/test_host_app:main.m"],
        bundle_id = "com.example.ios-app-host-{}".format(version),
        entitlements = "@build_bazel_rules_ios//rules/test_host_app:ios.entitlements",
        families = [
            "iphone",
            "ipad",
        ],
        launch_storyboard = "@build_bazel_rules_ios//rules/test_host_app:LaunchScreen.storyboard",
        minimum_os_version = version,
        visibility = ["//visibility:public"],
        **kwargs
    )
