//
//  EditPostView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct EditPostView: View {
    @Binding var pp: PostInformation
    @Binding var showingSheet: Bool
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                showingSheet = false
            } label: {
                Text("완료")
                    .fontWeight(.bold)
                    .foregroundColor(Color.mainGreen)
                    .padding(.leading, 285)
            } .padding(.top, 30)
        
            makeHeadLine(HeadLineName: "Task Name", paddingTrailing: 255)
            TextField(pp.toDoTitle, text: $pp.toDoTitle)
                .background(Color.white)
                .foregroundStyle(Color.subGray)
                .padding(.leading, 20)
                .padding(.trailing, 10)
            
            makeHeadLine(HeadLineName: "Category", paddingTrailing: 270)
            TextField(pp.category, text: $pp.category)
                .background(Color.white)
                .foregroundStyle(Color.subGray)
                .padding(.leading, 20)
                .padding(.trailing, 10)
        
            VStack {
                makeHeadLine(HeadLineName: "Setting Date", paddingTrailing: 240)
                DatePicker("Start \(timeFormatter.string(from: pp.startDate))", selection: $pp.startDate,
                           displayedComponents: [.date, .hourAndMinute])
                .padding(.leading, 20)
                    .foregroundStyle(Color.subGray)
                DatePicker("End \(timeFormatter.string(from: pp.endDate))", selection: $pp.endDate,
                           displayedComponents: [.hourAndMinute])
                .padding(.leading, 20)
                .foregroundStyle(Color.subGray)
               
            }
            
            HStack {
                makeHeadLine(HeadLineName: "To Do List", paddingTrailing: 120)
                    .padding(.leading, 4)
                Button {
                    pp.toDoList.append(PostToDoList(toDoText: ""))
                } label: {
                    Text("추가")
                        .foregroundColor(Color.mainGreen)
                        .padding(.leading, 80)
                        .padding(.trailing, 20)
                        .fontWeight(.semibold)
                }
            }
            VStack{
                List{
                    ForEach(pp.toDoList.indices, id: \.self) { index in
                        TextField("Write To do List", text: $pp.toDoList[index].toDoText)
                    }
                    .onDelete(perform: { indexSet in removeRows(at: indexSet) })
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        pp.toDoList.remove(atOffsets: offsets)
    }
    
    @ViewBuilder
    func makeHeadLine(HeadLineName: String, paddingTrailing: Double) -> some View {
        Text(HeadLineName)
            .foregroundStyle(Color.mainGreen)
            .font(.title3)
            .fontWeight(.bold)
            .padding(.trailing, paddingTrailing)
    }
}
