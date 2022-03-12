//
//  LoginView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 3/11/22.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject var loginData = LoginViewModel()
    @Binding var showLoginPage: Bool
    
    var body: some View {
        
        ZStack{
            
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .overlay(Color.black.opacity(0.35))
                .ignoresSafeArea()
            
            VStack(spacing: 25){
                Text("Self Check In")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 30, content: {
                    Text("그룹에 참여해 주세요")
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("로그인을 해야 그룹에 참여할 수 있습니다. 로그인을 완료해서 출석체크 기록을 쌓아보세요!")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                })
                .padding(.horizontal,30)
                
                Spacer()

                SignInWithAppleButton { (request) in
                    
                    // requesting paramertes from apple login...
                    loginData.nonce = randomNonceString()
                    request.requestedScopes = [.email,.fullName]
                    request.nonce = sha256(loginData.nonce)
                    
                } onCompletion: { (result) in
                    
                    // getting error or success...
                    
                    switch result {
                    case .success(let user):
                        print("success")
                        // do Login With Firebase...
                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                            print("error with firebase")
                            return
                        }
                        loginData.authenticate(credential: credential)
                        showLoginPage = false
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height: 55)
                .clipShape(Capsule())
                .padding(.horizontal,40)
                .offset(y: -70)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLoginPage: .constant(true))
    }
}
