//
//  HomeViewRow.swift
//  Learning App
//
//  Created by Antonio Gormley on 29/06/2021.
//

import SwiftUI


struct HomeViewRow: View {
    
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack {
                //image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Spacer()
                //text
                VStack (alignment: .leading, spacing: 10){
                    //headline
                    Text(title)
                        .bold()
                    //description
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    //icons
                    HStack {
                        // number lesson/questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(Font.system(size: 10))
                       
                        Spacer()
                        //time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(.caption)
                    }
                    
                }
                .padding(.leading,20)
                
            }
            .padding(.horizontal, 20)
        }    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title:"Learn Swift", description: "some decription", count: "10 lessons", time: "2 hours")
    }
}
