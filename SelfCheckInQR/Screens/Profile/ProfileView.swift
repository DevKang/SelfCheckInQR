//
//  ProfileView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/10.
//

import SwiftUI
import Firebase

struct Profile: Identifiable {
    var id: UUID = UUID()
    let name: String
    var value: String
    let detailType: DetailType
}

struct ProfileView: View {
    @State var arrayData = [Profile(name: "참가중인 그룹 코드", value: "", detailType: .group),
                            Profile(name: "로그인 된 ID", value: "", detailType: .login),
    ]
    @State private var showingDetails = false
    @Binding var showLoginPage: Bool
    @Binding var currentTab: Tab
    @AppStorage("loginStatus") var loginStatus = false
    @State private var userName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(arrayData) { value in
                    NavigationLink {
                        ProfileDetailView(detailType: value.detailType)
                    } label: {
                        HStack {
                            Text(value.name)
                            Spacer()
                            Text(value.value)
                        }
                    }
                }
                .padding(.top)
                
                if loginStatus {
                    Button {
                        withAnimation {
                            loginStatus = false
                            UserDefaults.standard.set(loginStatus,
                                                      forKey: "loggedIn")
                        }
                        try! Auth.auth().signOut()
                        currentTab = .qrcode
                    } label: {
                        Text("로그아웃")
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                            .hCenter()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Purple"))
                            }
                            .padding(.horizontal, 40)
                    }
                    
                    
                }
            }
            .onAppear(perform: {
                
                let isLogedIn = UserDefaults.standard.bool(forKey: "isGroupAdmin")
                
                if isLogedIn {
                    if arrayData.count < 3 {
                        arrayData.append(Profile(name: "QR Code 생성", value: "", detailType: .qrGenerator))
                    }
                }
            })
            .navigationBarTitle("\(userName)님", displayMode: .inline)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
        .onAppear(perform: {
            
            // TODO: 사용자 데이터 불러오기
            // 만약 데이터가 있다면 불러오고
            // 없으면 기본값으로 셋팅하기
            
            showLoginPage = !loginStatus
            if userName == "" {
                let randomUserName = getTempRandomUsername()
                if let tempUserName = UserDefaults.standard.string(forKey: "userName") {
                    userName = tempUserName
                } else {
                    UserDefaults.standard.set(randomUserName,
                                              forKey: "userName")
                    userName = randomUserName
                }
                
                
            } else {
                userName = UserDefaults.standard.string(forKey: "userName") ?? "이현호"
            }
            
            if arrayData[0].value == "" {
                
                if let loginStatus = UserDefaults.standard.string(forKey: "groupCode") {
                    arrayData[0].value = loginStatus
                } else {
                    arrayData[0].value = "미참가"
                }
            }
            
            if arrayData[1].value == "" {
                let user = Auth.auth().currentUser
                if let user = user {
                    arrayData[1].value = user.email ?? "error"
                }
            }
        })
        .sheet(isPresented: $showLoginPage,
               onDismiss: {
            showLoginPage = false
            currentTab = .qrcode
        }) {
            LoginView(showLoginPage: $showLoginPage)
        }
    }
    
    private func getTempRandomUsername() -> String {
        let animalNames = ["기린", "코끼리", "사자", "팬더", "고라니"]
        let randomNumber = Int.random(in: 0...999)
        return "\(animalNames.randomElement() ?? "비둘기")\(randomNumber)"
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showLoginPage: .constant(false),
                    currentTab: .constant(.qrcode),
                    loginStatus: true)
    }
}

extension View {
    
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
}
