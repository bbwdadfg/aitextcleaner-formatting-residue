// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AiTextCleanerFormattingResidue",
    platforms: [.macOS(.v12)],
    products: [.library(name: "AiTextCleanerFormattingResidue", targets: ["AiTextCleanerFormattingResidue"])],
    targets: [
        .target(name: "AiTextCleanerFormattingResidue", path: "ecosystems/swift-package/Sources/AiTextCleanerFormattingResidue"),
        .testTarget(name: "AiTextCleanerFormattingResidueTests", dependencies: ["AiTextCleanerFormattingResidue"], path: "ecosystems/swift-package/Tests/AiTextCleanerFormattingResidueTests")
    ]
)
