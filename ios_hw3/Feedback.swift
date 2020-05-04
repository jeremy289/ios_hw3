//
//  Feedback.swift
//  ios_hw3
//
//  Created by User04 on 2020/5/4.
//  Copyright © 2020 7021. All rights reserved.
//

import SwiftUI

struct Feedback: View {
    @State var name=""
    @State var selectChamp=0
    @State var Point=0.0
    @State var showAlert=false
    @State var champ=""
    let champs = ["台灣啤酒","富邦勇士","桃園璞園","台北達欣","裕隆納智捷"]
    var body: some View {
       VStack
        {
           
            Form{
                TextField("Name",text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
           
            Picker("選擇最喜愛的冠軍球隊", selection: self.$selectChamp) {
                ForEach(self.champs, id: \.self) { (champ) in
                    Text(champ)
                }
            }.pickerStyle(WheelPickerStyle())
                PointSlider(Point:$Point)
                Button("確定"){
                    self.showAlert = true
                }
                .offset(x:175,y:0)
                .font(.system(size: 20))
                //offset(x:100,y:0)
                .alert(isPresented: $showAlert) { () -> Alert in
                let result: String
                    result = self.name+"最愛的隊伍:"+champs[self.selectChamp]
                        return Alert(title: Text(result))
                }
            
            }
            
            if Point>=8
            {
                Image("finger")
                .resizable()
                .scaledToFit()
            }
            else if Point>=5 && Point < 8
            {
                Image("notgood")
                .resizable()
                .scaledToFit()
                //.frame(width: 100, height: 100)
            }
            else if Int(Point)>=1 && Int(Point) < 5
            {
                Image("sorry")
                .resizable()
                .scaledToFit()
                //.frame(width: 100, height: 100)
            }
            
            
        }
    
    }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        Feedback()
    }
}
struct PointSlider: View {
    
    @Binding var Point: Double
    
    var body: some View {
        HStack {
            Text("App滿意度\n(滿分10分)")
            Slider(value: self.$Point, in: 0...10,step: 1, minimumValueLabel: Image(systemName: "suit.heart.fill").imageScale(.small), maximumValueLabel: Image(systemName: "suit.heart.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}
