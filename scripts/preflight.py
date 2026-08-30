#!/usr/bin/env python3
"""Offline structural preflight for the multi-ecosystem package surfaces."""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SITE = "https://aitextcleaner.pro/"


def fail(message: str) -> None:
    raise ValueError(message)


def main() -> int:
    manifest_path = ROOT / "surface-manifest.json"
    release_path = ROOT / "release" / "v0.2.0.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    release = json.loads(release_path.read_text(encoding="utf-8"))

    if manifest["version"] != "0.2.0":
        fail("root extension version must be 0.2.0")
    if manifest["license"] != "MIT":
        fail("root license must be MIT")
    for field in ("homepage", "repository", "source"):
        if manifest[field] != SITE:
            fail(f"root {field} must point to aitextcleaner.pro")

    surfaces = manifest["surfaces"]
    if len(surfaces) != 22:
        fail(f"expected 22 surfaces, found {len(surfaces)}")
    ids = {surface["id"] for surface in surfaces}
    if any("hex" in surface_id.lower() for surface_id in ids):
        fail("Hex.pm/HexDocs are forbidden")

    for surface in surfaces:
        surface_root = (ROOT / surface["path"]).resolve()
        if ROOT not in surface_root.parents and surface_root != ROOT:
            fail(f"surface escapes package root: {surface['id']}")
        expected_version = "0.1.0" if surface["id"] == "python-pypi" else "0.2.0"
        if surface["version"] != expected_version:
            fail(f"wrong version for {surface['id']}: {surface['version']}")
        if surface.get("license") != "MIT":
            fail(f"wrong license for {surface['id']}")
        for field in ("homepage", "repository", "source"):
            if surface.get(field) != SITE:
                fail(f"wrong {field} for {surface['id']}")
        for category in ("metadata", "sourceFiles", "testFiles"):
            for relative in surface[category]:
                candidate = surface_root / relative
                if not candidate.is_file():
                    fail(f"missing {category} for {surface['id']}: {relative}")
        for required in ("README.md", "LICENSE"):
            if not (surface_root / required).is_file():
                fail(f"missing {required} for {surface['id']}")

    chocolatey = next(surface for surface in surfaces if surface["id"] == "chocolatey-candidate")
    if chocolatey["status"] != "candidate-only" or chocolatey.get("publishable") is not False:
        fail("Chocolatey must remain a non-publishable candidate")
    if release["version"] != "0.2.0" or release["githubTag"] != "v0.2.0":
        fail("new release metadata must target v0.2.0")
    if release["publishPerformed"] or release["networkCallsPerformed"]:
        fail("preflight metadata must record no publish or network activity")

    print("offline preflight OK: 22 surfaces; extension version 0.2.0; Python baseline 0.1.0")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (KeyError, OSError, ValueError, json.JSONDecodeError) as error:
        print(f"preflight failed: {error}", file=sys.stderr)
        raise SystemExit(1)
