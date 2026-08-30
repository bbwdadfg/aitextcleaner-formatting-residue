Pod::Spec.new do |spec|
  spec.name = "aitextcleaner-formatting-residue"
  spec.version = "0.2.0"
  spec.summary = "Local formatting-residue cleanup helper for copied text."
  spec.description = "Deterministic local formatting cleanup for copied text."
  spec.homepage = "https://aitextcleaner.pro/"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author = { "AI Text Cleaner" => "https://aitextcleaner.pro/" }
  spec.source = { :git => "https://github.com/bbwdadfg/aitextcleaner-formatting-residue.git", :tag => "v0.2.0" }
  spec.source_files = "ecosystems/cocoapods/Sources/**/*.swift"
  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "10.15"
  spec.swift_version = "5.7"
end
