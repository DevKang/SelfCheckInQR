//
//  ProfileView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/10.
//

import SwiftUI

struct Profile: Identifiable {
    var id: UUID = UUID()
    let name: String
    let value: String
}

struct ProfileView: View {
    @State var arrayData = [Profile(name: "참가중인 그룹 코드", value: "ASDFS"),
                            Profile(name: "로그인 된 ID", value: "leeo@kakao.com")]
    @State private var showingDetails = false
    @State var detailType: DetailType = .group
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View{
        
        VStack(spacing: 0) {
            
            HStack{
                Text("이현호님")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            
            Divider()
            NavigationView {
                VStack {
                    List(arrayData) { value in
                        NavigationLink {
                            ProfileDetailView(detailType: $detailType)
                        } label: {
                            HStack {
                                Text(value.name)
                                Spacer()
                                Text(value.value)
                            }
                        }
                    }
                    Button {
                        
                    } label: {
                        Text("로그아웃")
                    }
                }
                .navigationBarTitle("Profile")
                .navigationBarHidden(self.isNavigationBarHidden)
                .onAppear {
                    self.isNavigationBarHidden = true
                }.padding(.top)
            }
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
