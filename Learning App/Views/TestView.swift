//
//  TestView.swift
//  Learning App
//
//  Created by Antonio Gormley on 02/07/2021.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack {
                //q number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0 )")
                //q
                CodeTextView()
                
                //answers
                //button
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        }else{
            ProgressView()
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
