import Foundation
import RomeKit

struct UploadCommand {
    
    func upload(platforms: String?, additionalArguments: [String]) {
        
        if !Cartfile().exists() {
            Carthage(["update", "--no-build"])
            Carthage(["checkout", "--no-use-binaries"])
        } else {
            Carthage(["checkout"])
            Carthage(["checkout", "--no-use-binaries"])
        }

        var dependenciesToBuild = [String:String]()
        let dependencies = Cartfile().load()

        for (name, revision) in dependencies {
            print("")
            print(name, revision)
            if Rome().getLatestByRevison(name: name, revision: revision) == nil {
                dependenciesToBuild[name] = revision
            }
        }

        let dependenciesToUploadArray = Array(dependenciesToBuild.keys.map { $0 })
        let directory = Environment().currentDirectory()!
        let buildDir = "Carthage/Build/"
        print("Current dir \(directory)")

        try? FileManager.default.createDirectory(atPath: buildDir, withIntermediateDirectories: true, attributes: nil)

        if dependenciesToUploadArray.count > 0 {
            for dependency in dependenciesToUploadArray {
                let dependencyPath = "\(directory)/Carthage/Checkouts/\(dependency)"
                let carthageBuildPath = "Carthage/Checkouts/\(dependency)"
                let carthageDepBuildPath = "\(carthageBuildPath)/\(buildDir)"


                try? FileManager.default.removeItem(atPath: carthageDepBuildPath)

                try? FileManager.default.copyItem(atPath: buildDir,
                                                                   toPath: carthageDepBuildPath)

                print("Trying to pre archive \(dependency)")
                var status = Carthage(["archive", "--project-directory", carthageBuildPath])
                if status.status != 0 {
                    try? FileManager.default.removeItem(atPath: carthageDepBuildPath)
                    print("Couldn't find framework\nCheckout project dependency \(dependency)")
                    Carthage(["checkout", dependency])

                    print("Checkout inner dependencies for \(dependency)")
                    Carthage(["bootstrap", "--no-build", "--project-directory", dependencyPath])

                    print("Building \(dependency) for archive")

                    var buildArchive = ["build", "--no-skip-current", "--project-directory", dependencyPath]

                    if let buildPlatforms = platforms {
                        buildArchive.append("--platform")
                        buildArchive.append(buildPlatforms)
                    }

                    Carthage(buildArchive)
                    status = Carthage(["archive", "--output", directory], path: dependencyPath)
                }
                
                Helpers().uploadAsset(name: dependency, revision: dependenciesToBuild[dependency]!, filePath: getFrameworkPath(taskStatus: status))
            }
        }
        
        print("Upload complete")
        
    }
    
}
