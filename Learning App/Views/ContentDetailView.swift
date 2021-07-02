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
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)

                        
                        Text("Next Lesson \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
            })
            }else{
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)

                        
                        Text("Complete")
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
