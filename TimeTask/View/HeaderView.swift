//
//  HeaderView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct HeaderView: View {
    @State private var progress: CGFloat = 0.0 // 할 일 완료 비율
    
    var body: some View {
        VStack {
            // 게이지 바
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: 300, height: 20)
                
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 300 * progress, height: 20)
            }
            
            // 완료 버튼
            Button(action: {
                withAnimation {
                    progress += 0.1 // 완료 비율 증가
                    if progress > 1.0 {
                        progress = 1.0 // 게이지가 가득 찼을 때 최대 값으로 설정
                    }
                }
            }) {
                Text("Complete Task")
            }
        }
        .padding()
    }
}

#Preview {
    HeaderView()
}
