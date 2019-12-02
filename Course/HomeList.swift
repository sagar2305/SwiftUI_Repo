
//
//  HomeList.swift
//  Course
//
//  Created by Ajinkya Relekar on 02/12/19.
//  Copyright © 2019 Ajinkya Relekar. All rights reserved.
//

import SwiftUI

struct HomeList: View {
    
    @State var showContent = false
    
    let coursesData = [
        CourseData(title: "Build an app with SwiftUI",
               image: "Illustration1",
               color: Color("background3"),
               shadowColor: Color("backgroundShadow3")),
        CourseData(title: "Design and animate your UI",
               image: "Illustration2",
               color: Color("background4"),
               shadowColor: Color("backgroundShadow4")),
        CourseData(title: "Swift UI Advanced",
               image: "Illustration3",
               color: Color("background7"),
               shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
        CourseData(title: "Framer Playground",
               image: "Illustration4",
               color: Color("background8"),
               shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
        CourseData(title: "Flutter for Designers",
               image: "Illustration5",
               color: Color("background9"),
               shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    ]

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Courses")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("21 courses")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 70)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 30) {
                    ForEach(coursesData) { item in
                        GeometryReader { geometry in
                            CourseView(course: item)
                                .sheet(isPresented: self.$showContent) { ContentView() }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in: .global).minX - 40) / -20
                                ), axis: (x: 0, y: 10.0, z: 0))
                            
                        }
                        .frame(width: 246, height: 150)
                    }
                }
                .padding(.leading, 40)
                .padding(.bottom, 60)
                .padding(.top, 30)
                Spacer()
            }
        }
        .padding(.top, 78)
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}

struct CourseView: View {
    var course: CourseData
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)
                .frame(width: 150)
            Spacer()
            Image(course.image)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 246, height: 150)
            .padding(.bottom, 30)

        }
        .background(course.color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: course.shadowColor, radius: 20, x: 0, y: 20)
    }
}

struct CourseData : Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

