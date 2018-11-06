import Foundation
import RomeKit

struct ArchiveCommand {
    func upload(productName: String, revision: String, platforms: String?) {

        print("Archiving \(productName)")

        let status = Carthage(["archive"])

        Helpers().uploadAsset(name: productName, revision: revision, removeFile: false, filePath: getFrameworkPath(taskStatus: status))
        print("Upload complete")
    }
}
