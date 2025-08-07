import ProjectDescription


public extension TargetScript {
    
    /// Shell Script를 Tuist에 넣는 법
    
    static let SwiftLintString = TargetScript.pre(
        script: """
    if test -d "/opt/homebrew/bin/"; then
        PATH="/opt/homebrew/bin/:${PATH}"
    fi

    export PATH

    if which swiftlint > /dev/null; then
        swiftlint
    else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
    """,
        name: "SwiftLintString"
    )
}
