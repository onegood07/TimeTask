//
//  PostToDoList.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct PostToDoList: Identifiable {
    var id = UUID()
    var isFinished: Bool = false
    var toDoText: String
}
