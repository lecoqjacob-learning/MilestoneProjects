//
//  ImageUtils.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//

import Foundation

struct ImageUtils {
    func setImage(image: Data) -> String? {
        let url = getDocumentsDirectory().appendingPathComponent(UUID().uuidString)

        do {
            try image.write(to: url, options: [.atomicWrite, .completeFileProtection])
            return url.lastPathComponent
        }
        catch {
            print("Could not write image: " + error.localizedDescription)
        }

        return nil
    }

    func getImage(imagePath: String?) -> Data? {
        guard let imagePath = imagePath else { return nil }

        let url = getDocumentsDirectory().appendingPathComponent(imagePath)
        if let data = try? Data(contentsOf: url) {
            return data
        }

        return nil
    }
    
    func deleteImage(imagePath: String?) {
        guard let imagePath = imagePath else { return }
        
        do {
            let url = getDocumentsDirectory().appendingPathComponent(imagePath)
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Could not delete image: \(error.localizedDescription)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
