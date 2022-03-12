//
//  QRCodeScanView.swift
//  SelfCheckInQR
//
//  Created by hyunho lee on 2022/03/10.
//

import SwiftUI

struct QRCodeScanView: View {
    
    @StateObject var viewModel = QRCodeScanViewModel()
    //let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack {
            ScannerView(scannedCode: $viewModel.scannedCode,
                        alertItem: $viewModel.alertItem)
                .frame(maxWidth: 275,
                       maxHeight: 275)
                .overlay(Rectangle()
                            .stroke(Color.yellow,
                                    style: StrokeStyle(lineWidth: 5.0,
                                                       lineCap: .round,
                                                       lineJoin: .bevel,
                                                       dash: [60, 215],
                                                       dashPhase: 29)))
            Spacer().frame(height: 60)
            
            Label("QR을 스캔해주세요:", systemImage: "qrcode.viewfinder")
                .font(.title)
            
            Text(viewModel.statusText)
                .bold()
                .font(.largeTitle)
                .foregroundColor(viewModel.statusTextColor)
                .padding()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismissButton)
        }
        
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView()
    }
}
