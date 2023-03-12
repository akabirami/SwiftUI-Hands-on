//
//  ViewsAndModifiers.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 10/03/2023.
//

import SwiftUI

struct ViewsAndModifiers: View {
    @State private var checkText = ""
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
   
    var body: some View {
        VStack {
            motto1
            motto2
            CapsuleText(content: "1")
                .padding(10)
            CapsuleText(content: "2")
            GridStack(rows: 2, cols: 2) { row, col in
                VStack {
                    Text("RR: \(row) CC: \(col)")
                    Text("R: \(row) C: \(col)")
                }
            }
        }
    }
}

struct CapsuleText: View {
    var content: String
    var body: some View {
        Text(content)
            .font(.largeTitle)
            .padding(20)
            .background(.blue)
            .clipShape(Capsule())
            .modifier(WaterMark(text: "This is watermark"))
    }
}

struct WaterMark: ViewModifier {

    var text: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Text(text)
        }
    }
}

struct GridStack<Content: View>: View {
    
    var rows: Int
    var cols: Int
    @ViewBuilder var content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows , id: \.self) { r in
                HStack {
                    ForEach(0..<cols, id: \.self) { c in
                        content(r,c)
                    }
                }
            }
        }
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}
