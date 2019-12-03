//
//  UpdateList.swift
//  Course
//
//  Created by Ajinkya Relekar on 02/12/19.
//  Copyright © 2019 Ajinkya Relekar. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    @State var showSettings = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { item in
                    NavigationLink(destination: UpdateDetail(
                        title: item.title,
                        text: item.text,
                        image: item.image)) {
                            HStack(alignment: .top) {
                                
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .background(Color("background"))
                                    .cornerRadius(20)
                                    .padding(.trailing, 4)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.text)
                                        .lineLimit(3)
                                        .font(.system(size: 15))
                                        .lineSpacing(4)
                                        .frame(height: 50)
                                    
                                    Text(item.date)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                            }
                    }
                    .padding(.vertical, 8)
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
            .onMove(perform: move)
            }
                
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(trailing:
                Button(action: { self.showSettings.toggle() }) {
                    Image(systemName: "gear")
                        .sheet(isPresented: self.$showSettings) {
                            Text("Settings")
                    }
                }
            )
                .navigationBarItems(
                    leading: Button(action: addUpdate) { Text("Add Update") },
                    trailing: EditButton()
            )
            
        }
    }
    
    func addUpdate() {
        store.updates.append(Update(image: "Certificate2", title: "SwiftUI Advanced", text: "This course will focus on API data.", date: "JUL 26"))
    }
    
    func move(from source: IndexSet, to destination: Int) {
        store.updates.move(fromOffsets: source, toOffset: destination)
    }

}



struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}
