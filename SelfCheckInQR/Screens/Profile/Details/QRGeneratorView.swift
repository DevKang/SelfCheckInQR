//
//  QRGeneratorView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/12.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRGeneratorView: View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private let code = "ASDFGH"
    private let todayDate = "2022-03-12"
    
    var body: some View {
        let encode = encodeDataToBase64(code: code, todayDate: todayDate)
        
        Image(uiImage: generateQRCode(from: "\(encode)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private func encodeDataToBase64(code: String, todayDate: String) -> String {
        let stringData = code + todayDate
        let data = stringData.data (using: .utf8)

        guard let encode = data?.base64EncodedString() else {
            return "error"
        }
        
        return encode
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        QRGeneratorView()
    }
}
