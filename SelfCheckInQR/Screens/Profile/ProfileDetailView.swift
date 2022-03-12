//
//  ProfileDetailView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/11.
//

import SwiftUI

enum DetailType {
    case login
    case group
    case qrGenerator
}

struct ProfileDetailView: View {
    
    @State var detailType: DetailType
    
    var body: some View {
        switch detailType {
        case .group:
            // 그룹 참여하기
            GroupView()
        case .login:
            Text("login")
        //TODO: 그룹 오너만 생성할 수 있게하기
        case .qrGenerator:
            QRGeneratorView()
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(detailType: .qrGenerator)
    }
}
