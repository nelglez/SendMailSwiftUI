//
//  ContentView.swift
//  SendMailSwiftUI
//
//  Created by Nelson Gonzalez on 2/9/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State private var emailTitle = ""
    @State private var messageBody = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("Email Title", text: $emailTitle).padding().border(Color.gray, width: 1).padding([.leading, .trailing, .top])
                TextField("Body...", text: $messageBody).padding().border(Color.gray, width: 1).padding([.leading, .trailing, .top])
                
                if !emailTitle.isEmpty && !messageBody.isEmpty {
                    Button(action: {
                        
                        self.isShowingMailView.toggle()
                        self.emailTitle = ""
                        self.messageBody = ""
                        
                    }) {
                        Text("Send Email")
                    }.disabled(!MFMailComposeViewController.canSendMail()).sheet(isPresented: $isShowingMailView) {
                    
                        MailView(result: self.$result, emailTitle: self.$emailTitle, messageBody: self.$messageBody)
                        
                    }.padding()
                }
                
                
                Spacer()
            }.navigationBarTitle("Send Email")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
