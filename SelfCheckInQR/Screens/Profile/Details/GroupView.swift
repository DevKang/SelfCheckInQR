//
//  GroupView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/12.
//

import SwiftUI

struct GroupView: View {
    @State var groupCode: String = ""
    @State var completeMessage: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            // TODO: 그룹 생성하기 문제
            // 1 + 버튼 넣기
            // 2 모달 띄우기
            // 3 파베에 그룹 코드 넣기
            // 4 그룹코드에는 오너도 넣기
            
            TextField("그룹 코드를 입력해주세요.", text: $groupCode)
                .modifier(ShadowModifier())
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Purple"), lineWidth: 2))
                
            Button(action: {
                //TODO: 그룹코드 저장
                groupCode = ""
                completeMessage = "코드가 입력되었습니다."
            }, label: {

                Text("확인")
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .hCenter()
                    .background(Color("Purple"))
                    .foregroundColor(Color(UIColor.label))
                    .cornerRadius(5)
            })
            .padding(.top,20)
            .disabled(groupCode == "")
            .opacity(groupCode == "" ? 0.5 : 1)
            
            Text(completeMessage)
                .padding(.vertical, 30)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}

struct ShadowModifier: ViewModifier {
    
    // changing based on ColorScheme
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        
        return content
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(colorScheme != .dark ? Color.white : Color.black)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: 5, y: 5)
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: -5, y: -5)
    }
}
