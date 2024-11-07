//
//  TimeLineView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct TimeLineView: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    let equalDate: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM dd"
        return formatter
    }()
    
    @State var selectedDate = Date()
    @State var posts: [PostInformation] = PostInformation.dummy
    @State var showSheet = false
    @State var currentTime = Date()
    @State private var progress: CGFloat = 0.0
    @State var currentPostsCount = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.coverGray
                    .edgesIgnoringSafeArea(.all)
            
                VStack(alignment: .leading) {
                    HStack {
                        Text(makeDateInfomation(selectedInfo: "dd", from: selectedDate))
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(Color.subGray)
                        
                        VStack(alignment: .leading){
                            Text(makeDateInfomation(selectedInfo: "E", from: selectedDate))
                                .foregroundColor(Color.subGray)
                            Text(makeDateInfomation(selectedInfo: "MMMM yyyy", from: selectedDate))
                                .foregroundColor(Color.subGray)
                        }
                    }
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: 300, height: 20)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Rectangle()
                                .frame(width: 300 * progress, height: 20)
                                .foregroundColor(Color.mainGreen)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Spacer()
                        Image(systemName: "flame")
                            .resizable()
                            .frame(width: 30, height: 40)
                            .foregroundColor(progress >= 1.0 ? Color.mainGreen : Color.subGray)
                    } .padding(.bottom, 20)
                    
                    CalendarView(selectedDate: $selectedDate)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(Array(zip(posts.indices, posts)), id: \.0) { index, item in
                            if equalDate.string(from: selectedDate) == equalDate.string(from: posts[index].startDate) {
                                makeTimeLine(post: item, index: index, isOnNow: (item.startDate <= currentTime && currentTime <= item.endDate))
                            }
                        }
                    }
                }
                .padding()
                .toolbar { ToolbarItem(placement: .topBarTrailing) { addPostButton } }
                .sheet(isPresented: $showSheet) {
                    AddPostView { post in
                        posts.append(post)
                        posts = posts.sorted(by: { $0.startDate < $1.startDate })
                        showSheet = false
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    private var addPostButton: some View {
        Button {
            showSheet = true
        } label: {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.mainGreen)
        }
    }
    
    private func makeDateInfomation(selectedInfo: String , from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate(selectedInfo)
        return dateFormatter.string(from: date)
    }
    
    @ViewBuilder
    private func makeTimeLine(post: PostInformation, index: Int, isOnNow: Bool) -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(dateFormatter.string(from: post.startDate))")
                        .foregroundColor(isOnNow ? Color.mainGreen : Color.subGray)
                        .font(.title3)
                        .fontWeight(isOnNow ? .semibold : .medium)
                    Text("\(dateFormatter.string(from: post.endDate))")
                        .foregroundColor(Color.subGray)
                        .fontWeight(isOnNow ? .medium : .light)
                }
                VStack {
                    Button(action: { withAnimation {
                        progress += 0.1
                        if progress > 1.0 {
                            progress = 1.0
                        }
                    }}, label: {
                        Image(systemName: isOnNow ? "bolt.circle.fill" : "circle")
                            .resizable()
                            .frame(width: isOnNow ? 20 : 10, height: isOnNow ? 20 : 10)
                            .foregroundStyle(isOnNow ? Color.mainGreen : Color.subGray)
                    }
                    )
                    Rectangle()
                        .frame(width: 0.5, height: 60)
                        .foregroundColor(Color.subGray)
                }
                
                NavigationLink {
                    DetailPage(pp: $posts[index]) {
                        posts.remove(at: index)
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 260, height: 80)
                            .foregroundColor(isOnNow ? Color.mainGreen : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text(post.toDoTitle)
                            .multilineTextAlignment(.leading)
                            .fontWeight(isOnNow ? .bold : .light)
                            .font(.title3)
                            .foregroundStyle(isOnNow ? Color.white : Color.subGray)
                    }
                }
            }
        }
    }
}

#Preview {
    TimeLineView()
}
