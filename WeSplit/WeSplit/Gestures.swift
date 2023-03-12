//
//  Gestures.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 11/03/2023.
//

import SwiftUI

struct Gestures: View {
    @GestureState var dragAmount = CGSize.zero
    @GestureState private var isLongPressed = false
    
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .offset(dragAmount)
                .gesture(
                    DragGesture().updating($dragAmount) { value, state, transaction in
                        state = value.translation
                    }
                )
            Text("Tap or Long Press")
                .foregroundColor(isLongPressed ? .red : .blue)
                .gesture(
                    LongPressGesture(minimumDuration: 2)
                        .onEnded { value in
                            print("Long press done")
                        }
                        .updating($isLongPressed) { currentState, gestureState, transaction in
                            gestureState = currentState
                        }
                )
        }
    }
}

struct DragGestureView: View {
 
    @State private var offsetValue = CGSize.zero
    @State private var highlightButton = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .offset(offsetValue)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offsetValue = value.translation
                        })
                )
            
            Text("Tap Me")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(15)
                .background(highlightButton ? Color.green : Color.yellow)
                .onTapGesture {
                    highlightButton.toggle()
                }
            }
    }
}

struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
