//
//  QRGenerator.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/13.
//

import Foundation

struct QRGenerator {
    
    func encodeDataToBase64() -> String {
        let code = UserDefaults.standard.string(forKey: "groupCode") ?? "error"
        let now = Date()
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        let todayDate = date.string(from: now)

        let stringData = code + todayDate
        let data = stringData.data (using: .utf8)

        guard let encode = data?.base64EncodedString() else {
            return "error"
        }
        
        return encode
    }
}
