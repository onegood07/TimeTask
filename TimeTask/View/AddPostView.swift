//
//  AddPostView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct AddPostView: View {
    @State var newPost = PostInformation(category: "", toDoTitle: "", startDate: Date(), endDate: Date(), toDoList: [])
    var addPost: (PostInformation) -> Void
    
    var body: some View {
        VStack {
            Button {
                addPost(newPost)
            } label : {
                Text("완료")
                    .fontWeight(.bold)
                    .foregroundColor(Color.mainGreen)
                    .padding(.leading, 285)
            } .padding(.top, 30)
            
            makeHeadLine(HeadLineName: "Task Name", paddingTrailing: 255)
            TextField("Write here", text: $newPost.toDoTitle)
                .background(Color.white)
                .foregroundStyle(Color.subGray)
                .padding(.leading, 20)
                .padding(.trailing, 10)
            
            makeHeadLine(HeadLineName: "Category", paddingTrailing: 270)
            TextField("Write here", text: $newPost.category)
                .background(Color.white)
                .foregroundStyle(Color.subGray)
                .padding(.leading, 20)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                makeHeadLine(HeadLineName: "Setting Date", paddingTrailing: 240)
                DatePicker("Start Date", selection: $newPost.startDate,
                           displayedComponents: [.date,.hourAndMinute])
                .foregroundColor(Color.mainGreen)

                DatePicker("End Time", selection: $newPost.endDate,
                           displayedComponents: [.hourAndMinute])
                .foregroundColor(Color.mainGreen)
                
            } .padding()
            
            HStack {
                makeHeadLine(HeadLineName: "To Do List", paddingTrailing: 120)
                    .padding(.leading, 4)
                
                Button {
                    newPost.toDoList.append(PostToDoList(toDoText: ""))
                } label: {
                    Text("추가")
                        .foregroundColor(Color.mainGreen)
                        .padding(.leading, 80)
                        .padding(.trailing, 20)
                        .fontWeight(.semibold)
                        
                }
            }
            
            VStack {
                List {
                    ForEach(newPost.toDoList.indices, id: \.self) { index in
                        TextField("Write To do List", text: $newPost.toDoList[index].toDoText)
                    }
                    .onDelete(perform: { indexSet in removeRows(at: indexSet) })
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        newPost.toDoList.remove(atOffsets: offsets)
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


