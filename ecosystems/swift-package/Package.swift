// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AiTextCleanerFormattingResidue",
    platforms: [.macOS(.v12)],
    products: [.library(name: "AiTextCleanerFormattingResidue", targets: ["AiTextCleanerFormattingResidue"])],
    targets: [
        .target(name: "AiTextCleanerFormattingResidue"),
        .executableTarget(
            name: "AiTextCleanerFormattingResidueSmoke",
            dependencies: ["AiTextCleanerFormattingResidue"],
            path: "Tests/AiTextCleanerFormattingResidueTests"
        )
    ]
)
