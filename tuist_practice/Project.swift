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
            dependencies: []
        ),
        .target(
            name: "tuist_practiceTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.tuist-practiceTests",
            infoPlist: .default,
            sources: ["tuist_practice/Tests/**"],
            resources: [],
            dependencies: [.target(name: "tuist_practice")]
        ),
    ]
)
