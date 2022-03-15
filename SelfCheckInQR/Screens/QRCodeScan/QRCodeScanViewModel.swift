//
//  QRCodeScanViewModel.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/10.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

final class QRCodeScanViewModel: ObservableObject {
    
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    private let ref = Database.database().reference(withPath: "attend-history")
    
    var statusText: String {
        if scannedCode.isEmpty {
            return "입력이 필요합니다."
        } else {
            let todaysAttendCode = QRGenerator().encodeDataToBase64()
            print(todaysAttendCode, scannedCode)
            if scannedCode == todaysAttendCode {
                saveCheckInHistory()
                return "출석되었습니다."
            } else {
                return "유효하지 않은 출석코드 입니다."//"\(scannedCode)는 올바른 값이 아닙니다."
            }
        }
    }
    
    var statusTextColor: Color {
        if scannedCode.isEmpty {
            return .red
        } else {
            let todaysAttendCode = QRGenerator().encodeDataToBase64()
            if scannedCode == todaysAttendCode {
                return .green
            } else {
                return .red
            }
        }
    }
    
    private func saveCheckInHistory() {
        // TODO: 어딘가에 저장 해야함
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email ?? "error"
            let userEmail = email.replacingOccurrences(of: ".", with: "*")
            // 기존의 데이터를 불러와야 함
            
            let userItemRef = ref.child(userEmail)
            let locationRef = userItemRef.childByAutoId()
            
            let now = Date()
//            let date = DateFormatter()
//            date.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let attendData = TaskMetaData(task: [
                Task(title: "힘내요!2", time: now)
            ], taskDate: now)
            
            let date = DateFormatter()
            date.dateFormat = "yyyy-MM-dd"
            let todayDate = date.string(from: now)
            //
//
//                let date = DateFormatter()
//                date.locale = Locale(identifier: "ko_kr")
//                date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
//                //date.timeZone = TimeZone(abbreviation: "NZST") // "2018-03-21 22:06:39"
//                date.dateFormat = "yyyy-MM-dd HH:mm:ss"

            do {
                let jsonData = try JSONEncoder().encode(attendData)
                let jsonString = String.init(data: jsonData, encoding: .utf8)
                locationRef.setValue(jsonString)
            } catch {
                print("encoding error")
            }
        }
        print("출석 이력이 저장되었습니다")
    }
}
