//
//  Person.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//

import CoreLocation
import SwiftUI

struct Person: Codable, Identifiable {
    var id = UUID()
    var name: String
    var imagePath: String?
    
    var locationRecorded = false
    /// Valid only if locationRecorded is true
    var latitude: Double = 0
    var longitude: Double = 0

    /// image is image data in any format
    mutating func setImage(image: Data) {
        imagePath = ImageUtils().setImage(image: image)
    }

    func getImage() -> Data? {
        return ImageUtils().getImage(imagePath: imagePath)
    }

    mutating func deleteImage() {
        ImageUtils().deleteImage(imagePath: imagePath)
        imagePath = nil
    }
}
