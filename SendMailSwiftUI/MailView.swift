//
//  MailView.swift
//  SendMailSwiftUI
//
//  Created by Nelson Gonzalez on 2/9/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//https://stackoverflow.com/questions/56784722/swiftui-send-email
//https://stackoverflow.com/questions/8203894/how-to-take-a-picture-and-send-it-as-an-email-attachment-in-ios

import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Binding var emailTitle: String
    @Binding var messageBody: String
    var toRecepients = ["nelglezfl@gmail.com"]
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject(emailTitle)
        vc.setMessageBody(messageBody, isHTML: false)
        vc.setToRecipients(toRecepients)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation, result: $result)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            defer {
                $presentation.wrappedValue.dismiss()
            }
            
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            
            switch result {
            case MFMailComposeResult.cancelled:
                print("Mail cancelled")
                self.result = .success(result)
            case MFMailComposeResult.saved:
                print("Mail saved")
                self.result = .success(result)
            case MFMailComposeResult.sent:
                print("Mail sent")
                self.result = .success(result)
            case MFMailComposeResult.failed:
                print("Failed to send: \(error?.localizedDescription ?? "")")
                self.result = .failure(error!)
            @unknown default:
                fatalError()
            }
            
        }
    }
}
