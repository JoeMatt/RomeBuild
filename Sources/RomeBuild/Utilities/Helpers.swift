import Foundation

struct Helpers {

    func uploadAsset(name: String, revision: String, removeFile: Bool = true, filePath: String? = nil) {
        var path: String
        if let filePath = filePath {
            path = filePath
        } else {
            path = "\(Environment().currentDirectory()!)/\(name).framework.zip"
        }

        do
        {
            Rome().addAsset(name: name, revision: revision, path: path)
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print(error)
        }
        
    }
}
