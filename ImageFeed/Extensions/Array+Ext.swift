//
//  Array+Ext.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 14.12.2023.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
