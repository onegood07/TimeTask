//
//  DetailPageView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct DetailPage: View {
    @Environment(\.dismiss) private var dismiss
    @State var showingSheet = false
    @Binding var pp: PostInformation
    var deletePost: () -> Void
    
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
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 99/255, green: 172/255, blue: 153/255), Color(red: 202/255, green: 218/255, blue: 164/255)]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        backButton
                        editButton
                        removeButton
                    } .padding()
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 340, height: 700)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        VStack(alignment: .leading) {
                            Text(pp.toDoTitle)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.mainGreen)
                                
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    makeImage(imageSystemName: "tag")
                                    Text(pp.category)
                                        .foregroundStyle(Color.mainGreen)
                                }
                                HStack {
                                    makeImage(imageSystemName: "calendar")
                                    Text(dateFormatter.string(from: pp.startDate))
                                        .foregroundStyle(Color.mainGreen)
                                }
                                HStack {
                                    makeImage(imageSystemName: "clock")
                                    Text("\(timeFormatter.string(from: pp.startDate))~\(timeFormatter.string(from: pp.endDate))")
                                        .foregroundColor(Color.mainGreen)
                                }
                            } .padding(.bottom, 20)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(0..<pp.toDoList.count, id: \.self) { listIndex in
                                    let isDone = pp.toDoList[listIndex].isFinished
                                    HStack {
                                        Button(action: {
                                            pp.toDoList[listIndex].isFinished.toggle()
                                        }, label: {
                                            Image(systemName: isDone ? "checkmark.square" : "square")
                                                .foregroundColor(isDone ? Color.subGray : Color.mainGreen)
                                        })
                                        Text(pp.toDoList[listIndex].toDoText)
                                            .font(.system(size: 20))
                                            .strikethrough(isDone ? true : false)
                                            .foregroundColor(isDone ? Color.subGray : Color.mainGreen)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 40)
                    }
                }
                .sheet(isPresented: $showingSheet, content: {
                    EditPostView(pp: $pp, showingSheet: $showingSheet)
                })
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 10, height: 20)
                .padding(.trailing, 250)
        })
    }
    
    private var editButton: some View {
        Button(action: {
            showingSheet = true
        }, label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
        })
    }
    
    private var removeButton: some View {
        Button(action: {
            deletePost()
            dismiss()
        }, label: {
            Image(systemName: "trash.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
        })
    }
    
    @ViewBuilder
    func makeImage(imageSystemName: String) -> some View {
        Image(systemName: imageSystemName)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(Color.mainGreen)
    }
    
}

