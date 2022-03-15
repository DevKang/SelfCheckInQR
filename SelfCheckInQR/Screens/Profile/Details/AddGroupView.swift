//
//  AddGroupView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/12.
//

import SwiftUI
import FirebaseDatabase

struct AddGroupView: View {
    @Binding var isAddGroupViewShow: Bool
    @State var groupCode: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("6자리 그룹 코드를 입력해주세요.", text: $groupCode)
                .modifier(ShadowModifier())
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Purple"), lineWidth: 2))
                
            Button(action: {
                
                var finalGroupCode: String

                if groupCode.count > 6 {
//                    let startIndex = groupCode.index(groupCode.startIndex, offsetBy: 0)
                    let endIndex = groupCode.index(groupCode.startIndex, offsetBy: 5)
                    let range = ...endIndex
                    finalGroupCode = groupCode[range].uppercased()
                } else {
                    finalGroupCode = groupCode.uppercased()
                }
                print(finalGroupCode)
                
                
                let testItemsReference = Database.database().reference(withPath: "group-codes")
                let userItemRef = testItemsReference.child(finalGroupCode)
                let values: [String: Any] = [ "id" : finalGroupCode ]
                userItemRef.setValue(values)
                
                UserDefaults.standard.set(finalGroupCode,
                                          forKey: "groupCode")
                UserDefaults.standard.set(true,
                                          forKey: "isGroupAdmin")
                
                #warning("그룹코드 저장 실패 케이스")
                
                isAddGroupViewShow = false
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

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct AddGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddGroupView(isAddGroupViewShow: .constant(false))
    }
}
