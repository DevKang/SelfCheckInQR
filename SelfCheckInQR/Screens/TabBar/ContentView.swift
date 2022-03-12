//
//  ContentView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/10.
//

import SwiftUI
import Firebase

enum Tab: String, CaseIterable {
    case qrcode
    case history = "calendar"
    case user = "person"
}

struct ContentView: View {
    @State var currentTab: Tab = .qrcode
    @State var currentDate: Date = Date()
    @State var showLoginPage: Bool = true
    @AppStorage("loginStatus") var loginStatus = false
    
    var body: some View {
        // TabView
        TabView(selection: $currentTab) {
            QRCodeScanView()
                .tag(Tab.qrcode)
            
            ScrollView(.vertical, showsIndicators: false) {
                HistoryView(currentDate: $currentDate)
            }
            .tag(Tab.history)
            .padding(.top)
            
            ProfileView(showLoginPage: $showLoginPage,
                        currentTab: $currentTab)
                .tag(Tab.user)
        }
        
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self){ tab in
                Button {
                    currentTab = tab
                } label: {
                    Image(systemName: tab.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .background(
                            Color("Purple")
                                .opacity(0.1)
                                .cornerRadius(5)
                                .blur(radius: 5)
                                .padding(-7)
                                .opacity(currentTab == tab ? 1 : 0)
                        )
                        .frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == tab ? Color("Purple") : Color(UIColor.systemGray))
                }
            }
        }
        .padding([.horizontal,.top])
        .padding(.bottom,10)
        .onAppear(perform: {
            loginStatus = UserDefaults.standard.bool(forKey: "loginStatus")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
