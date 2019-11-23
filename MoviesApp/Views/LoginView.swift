//
//  LoginView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 28/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Username")
                .font(.system(size: 20))
                .foregroundColor(.primary).colorInvert()
            TextField("Email", text: $email)
                .frame(height: 40)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(.primary).colorInvert()
            
            Text("Password")
                .font(.system(size: 20))
                .foregroundColor(.primary).colorInvert()
            SecureField("Password", text: $password)
                .frame(height: 40)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(.primary).colorInvert()
            
            Spacer()
        }
        .padding()
        .background(Color.secondary)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
