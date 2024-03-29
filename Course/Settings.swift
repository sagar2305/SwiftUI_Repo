//
//  Settings.swift
//  Course
//
//  Created by Ajinkya Relekar on 02/12/19.
//  Copyright © 2019 Ajinkya Relekar. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @State var receive = true
    @State var number = 1
    @State var selection = 1
    @State var date = Date()
    @State var email = ""
    @State var submit = false

    
    var body: some View {
        ZStack {

            BlurView(style: .systemMaterial)

            NavigationView {
                Form {
                    Toggle(isOn: $receive) {
                        Text("Receive notifications")
                    }
                    
                    Stepper(value: $number, in: 1...10) {
                        Text("\(number) Notification\(number > 1 ? "s": "") per week")
                        
                    }
                    
                    Picker(selection: $selection, label: Text("Favorite course")) {
                        Text("SwiftUI").tag(1)
                        Text("React").tag(2)
                    }

                    DatePicker(selection: $date) {
                        Text("Date")
                    }
                    
                    Section(header: Text("Email")) {
                        TextField("Your email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    Button(action: { self.submit.toggle() }) {
                            Text("Submit")
                    }

                    .alert(isPresented: $submit) { () -> Alert in
                        Alert(
                            title: Text("Thanks!"),
                            message: Text("\(number) email per month\n Favorite: \(selection)\n Date: \(date)")
                        )
                    }


                }
            
            .navigationBarTitle(Text("Settings"))
            }
            .padding(.top, 78)
        }
        .cornerRadius(30)

    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
