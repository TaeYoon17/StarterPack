import ProjectDescription

let project = Project(
    name: "tuist_practice",
    targets: [
        .target(
            name: "tuist_practice",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.tuist-practice",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ],
                            ]
                        ]
                    ],
                ]
            ),
            sources: ["tuist_practice/Sources/**"],
            resources: ["tuist_practice/Resources/**"],
            scripts: [ TargetScript.SwiftLintShell ],
            dependencies: [
                .external(name: "FlexLayout"),
                .external(name: "PinLayout"),
            ],
            
            settings:
                // FlexLayout (C++로 제작됨)을 이용하기 위한 프로젝트 설정
                .settings(
                    base: [
                        "OTHER_LDFLAGS": ["-ObjC"]
                    ],
                    configurations: [
                        .debug(name: "Debug", settings: [
                            "GCC_PREPROCESSOR_DEFINITIONS": ["DEBUG=1", "OTHER_MACRO=1", "FLEXLAYOUT_SWIFT_PACKAGE=1"],
                        ]),
                        .release(name: "Release", settings: [
                            "GCC_PREPROCESSOR_DEFINITIONS": ["RELEASE=1", "FLEXLAYOUT_SWIFT_PACKAGE=1"],
                        ])
                    ]
                )
        ),
        .target(
            name: "tuist_practiceTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.tuist-practiceTests",
            infoPlist: .default,
            sources: ["tuist_practice/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "tuist_practice")
            ]
        ),
    ]
)
