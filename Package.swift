// swift-tools-version:4.2
//
// Package.swift
// RomeBuild
//
// Created by Yehor Popovych on 22/09/2017.
// Copyright © 2017 Yehor Popovych. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "RomeBuild",
    products: [
        .executable(name: "romebuild", targets: ["RomeBuild"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JoeMatt/RomeKit.git", .branch("master")),
        .package(url: "https://github.com/IngmarStein/CommandLine.git", .branch("master")),
        .package(url: "https://github.com/sharplet/Regex.git", .branch("master")),
        .package(url: "https://github.com/jkandzi/Progress.swift.git", .branch("master"))
    ],
    targets: [
        .target(name: "RomeBuild", dependencies: ["RomeKit", "CommandLine", "Regex", "Progress"])
    ],
    swiftLanguageVersions: [.v4, .v4_2]
)
