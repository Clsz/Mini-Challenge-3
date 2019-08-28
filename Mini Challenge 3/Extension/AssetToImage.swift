//
//  AssetToImage.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 26/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import CloudKit
import UIKit

extension CKAsset {
    func toUIImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL!) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}
