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
    let value: String
    let detailType: DetailType
}

struct ProfileView: View {
    @State var arrayData = [Profile(name: "참가중인 그룹 코드", value: "", detailType: .group),
                            Profile(name: "로그인 된 ID", value: "leeo@kakao.com", detailType: .login),
                            Profile(name: "QR Code 생성", value: "", detailType: .qrGenerator)
    ]
    @State private var showingDetails = false
    @State var isNavigationBarHidden: Bool = true
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
            .navigationBarTitle("\(userName)님")
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
        .onAppear(perform: {
            showLoginPage = !loginStatus
            if userName == "" {
                let randomUserName = "코알라352"
                UserDefaults.standard.set(randomUserName,
                                          forKey: "userName")
            } else {
                userName = UserDefaults.standard.string(forKey: "userName") ?? "이현호"
            }
        })
        .sheet(isPresented: $showLoginPage,
               onDismiss: {
            showLoginPage = false
            #warning("for debuging")
            // for debuging  currentTab = .qrcode
        }) {
            LoginView(showLoginPage: $showLoginPage)
        }
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
