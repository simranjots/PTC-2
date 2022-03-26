//
//  FolderData.swift
//  PTC APP
//
//  Created by Simranjot Singh on 2022-02-26.
//  Copyright © 2022 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import RealmSwift

class FolderData: Object {
    @objc dynamic var folderName: String  = ""
    @objc dynamic var user: String  = ""
    let situationData = List<SituationData>()
}
