//
//  URLExtension.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import Foundation

extension URL {
    static func userURL() -> URL? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return nil
        }
        
        return url
    }
}
