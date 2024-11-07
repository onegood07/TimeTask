//
//  PostInformation.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct PostInformation: Identifiable {
    var id = UUID()
    var category: String
    var toDoTitle: String
    var startDate: Date
    var endDate: Date
    var toDoList: [PostToDoList]
}

extension PostInformation {
    static let dummy: [PostInformation] = [
        PostInformation(
            category: "Private",
            toDoTitle: "Wake Up",
            startDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 7, minute: 00).date!,
            endDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 7, minute: 30).date!,
            toDoList: [PostToDoList(isFinished: false, toDoText: "이불 정리하기"), PostToDoList(isFinished: false, toDoText: "노트북 켜기"),
                       PostToDoList(isFinished: false, toDoText: "아침 먹기")]),
        PostInformation(
            category: "Private",
            toDoTitle: "Prepare NC1",
            startDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 7, minute: 30).date!,
            endDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 13, minute: 30).date!,
            toDoList: [PostToDoList(isFinished: false, toDoText: "더미 데이터 정리하기"), PostToDoList(isFinished: false, toDoText: "메인 플로우 화면 만들기"), PostToDoList(isFinished: false, toDoText: "코드 마무리하기"),
                       PostToDoList(isFinished: false, toDoText: "노션 작성하기")]),
        PostInformation(
            category: "NC1",
            toDoTitle: "Academy",
            startDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 14, minute: 00).date!,
            endDate: DateComponents(calendar: .current, year: 2024, month: 5, day: 1, hour: 18, minute: 00).date!,
            toDoList: [PostToDoList(isFinished: false, toDoText: "체킹 앱 체크인"), PostToDoList(isFinished: false, toDoText: "NC1 Act part.1"),
                       PostToDoList(isFinished: false, toDoText: "NC1 Act part.2"), PostToDoList(isFinished: false, toDoText: "NC1 Act part.3")])
    ]
}
