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
}
struct ProfileDetailView: View {
    
    @Binding var detailType: DetailType
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(detailType: .constant(.group))
    }
}
