//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Antonio Gormley on 30/06/2021.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack {
        if url != nil {
        VideoPlayer(player: AVPlayer(url: url!))
            .cornerRadius(10)
        }
            //description
            
            CodeTextView()
            
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        
                        Text("Next Lesson \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
            })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
