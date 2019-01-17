//
//  AssignmentModel.swift
//  URLSessionBP
//
//  Created by Christopher Johnson on 1/12/19.
//  Copyright © 2019 Christopher Johnson. All rights reserved.
//

import UIKit
import Foundation

struct Assignment : Codable {
    
    let id:Int?
    let name:String?
    let description:String?
    let dueAt:Int?
    let unlock_at:Int?
    let timestamp:Int?



}
