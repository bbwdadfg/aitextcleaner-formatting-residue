Gem::Specification.new do |spec|
  spec.name = "aitextcleaner-formatting-residue"
  spec.version = "0.2.0"
  spec.summary = "Local formatting-residue cleanup helper for copied text."
  spec.authors = ["AI Text Cleaner"]
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"
  spec.homepage = "https://aitextcleaner.pro/"
  spec.metadata = {
    "source_code_uri" => "https://aitextcleaner.pro/"
  }
  spec.files = Dir["lib/**/*.rb", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]
end
