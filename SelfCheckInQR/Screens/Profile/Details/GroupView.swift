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
    @State var isAddGroupViewShow: Bool = false
    @Binding var insertGroupCode: String
    
    var body: some View {
        VStack(alignment: .center) {
            // TODO: 그룹 생성하기 문제
            // 3 파베에 그룹 코드 넣기
            // 4 그룹코드에는 오너도 넣기
            HStack {
                Spacer()
                Button {
                    isAddGroupViewShow = true
                } label: {
                    Image(systemName: "person.3")
                        .foregroundColor(Color("Purple"))
                }
            }
            .padding(.bottom)
            
            TextField("그룹 코드를 입력해주세요.", text: $groupCode)
                .modifier(ShadowModifier())
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Purple"), lineWidth: 2))
                
            Button(action: {
                //TODO: 그룹코드 저장
                //groupCode.uppercased()
                
                if groupCode.count > 6 {
                    let endIndex = groupCode.index(groupCode.startIndex, offsetBy: 5)
                    let range = ...endIndex
                    insertGroupCode = groupCode[range].uppercased()
                } else {
                    insertGroupCode = groupCode.uppercased()
                }
                
                UserDefaults.standard.set(groupCode.uppercased(),
                                          forKey: "groupCode")
                
                #warning("뒤로가기 화면 새로 그리기 insertGroupCode")
                print(insertGroupCode)
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
        .sheet(isPresented: $isAddGroupViewShow,
//               onDismiss: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>,
               content: {
            AddGroupView(isAddGroupViewShow: $isAddGroupViewShow)
        })
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(insertGroupCode: .constant("EXAM"))
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
