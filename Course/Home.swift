//
//  Home.swift
//  Course
//
//  Created by Ajinkya Relekar on 02/12/19.
//  Copyright © 2019 Ajinkya Relekar. All rights reserved.
//

import SwiftUI

struct Home: View {

    @State var show = false
    @State var showSettings = false
    @State var showProfile = false
    
    var body: some View {
        
        ZStack {
            
            HomeList()
            .blur(radius: show ? 20 : 0)
            .scaleEffect((showProfile || showSettings) ? 0.95 : 1)
            .animation(.default)
            
            
            MenuButton(show: $show)
            .animation(.spring())
            .offset(x: -36, y: (showProfile || showSettings) ? 0 : 80)
            
            MenuRight(show: $showProfile, showSettings: $showSettings)
            .offset(x: -16, y: (showProfile || showSettings) ? 0 : 88)
            .animation(.spring())

            ContentView()
            .cornerRadius(30)
            .shadow(radius: 20)
            .animation(.spring())
            .offset(y: showProfile ? 40 : UIScreen.main.bounds.height)
            
            MenuView(show: $show)
            
            Settings()
                .animation(.default)
                .offset(y: showSettings ? 40 : UIScreen.main.bounds.height)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuRow: View {
    var menu: Menu
    var body: some View {
        return HStack {
            Image(systemName: menu.icon)
                .imageScale(.large)
//                .foregroundColor(Color.red)
                .frame(width: 32, height: 32)
            Text(menu.title)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu : Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

struct MenuView: View {
    
    let menuData = [
        Menu(title: "My Account", icon: "person.crop.circle"),
        Menu(title: "Billing", icon: "creditcard"),
        Menu(title: "Team", icon: "person.and.person"),
        Menu(title: "Sign out", icon: "arrow.uturn.down")
    ]

    @Binding var show: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            ForEach(menuData) { item in
                MenuRow(menu: item)
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(30)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(BlurView(style: .systemMaterial))        .cornerRadius(30)
        .padding(.trailing, 60)
        .shadow(radius: 20)
        .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
        .animation(.default)
        .offset(x: show ? 0 : -UIScreen.main.bounds.width)
        .onTapGesture {
            self.show.toggle()
        }
    }
}

struct CircleButton: View {
    var icon = "person.crop.circle"
    var body: some View {
        HStack {
            Image(systemName: icon)
            .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)
        .foregroundColor(.black)
        .background(BlurView(style: .systemThickMaterial))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 10, y: 10)
    }
}

struct MenuButton: View {
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack {
                Button(action: { self.show.toggle() }) {
                    HStack {
                        Spacer()
                        Image(systemName: "list.dash")
                            .foregroundColor(.primary)
                        
                    }
                    .padding(.trailing, 20)
                    .frame(width: 90, height: 60)
                    .background(BlurView(style: .systemThickMaterial))
                    .cornerRadius(30)
                    .shadow(color: Color("buttonShadow"), radius: 10, y: 10)
                    
                }
                Spacer()
            }
            Spacer()
            
        }
    }
}

struct MenuRight: View {
    @Binding var show: Bool
    @Binding var showSettings: Bool

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Spacer()
                
                Button(action: {
                    self.showSettings.toggle()
                }) {
                    CircleButton(icon: "person.crop.circle")
                }
                
                Button(action: { self.show.toggle() }) {
                    CircleButton(icon: "bell")
                }
            }
            Spacer()
        }
    }
}
