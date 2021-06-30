//
//  ContentView.swift
//  Learning App
//
//  Created by Antonio Gormley on 29/06/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        NavigationView {
            VStack (alignment: .leading){
                Text("What do you want to do today?")
                    .padding(.leading,20)
                ScrollView{
                    LazyVStack {
                        ForEach(model.modules) { module in
                            //learning card
                            VStack (spacing:20){
                                NavigationLink(
                                    destination: ContentView()
                                        .onAppear(perform: {
                                            model.beginModule(moduleid: module.id)
                                        }),
                                    label: {
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                    })
                                
                                
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                            }
                        }
                    }.padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get started")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
