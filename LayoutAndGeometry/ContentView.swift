//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by aplle on 4/13/23.
//

import SwiftUI
struct OuterView:View{
    var body: some View {
        VStack{
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}
struct InnerView:View{
    var body: some View {
        HStack{
            Text("left")
            GeometryReader{geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Glob cent :\(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Local cent :\(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        print("cust cent :\(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
                
            }
            .background(.orange)
               
            Text("Right")
        }
    }
}







struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(getColor(for: geo.frame(in: .global).minY, full: fullView.frame(in: .global).maxY))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(getOpacity(for: geo.frame(in: .global).minY))
                            .scaleEffect(getScale(for: geo.frame(in: .global).minY) )
                            
                    }
                    .frame(height: 40)
                }
               
            }
        }
    }
    func getOpacity(for height:CGFloat)-> Double{
        if height > 200{
            return 1.0
        
        }
        return Double(abs(height / 200))
        
        
    }
    
    func getScale(for height:CGFloat)-> Double{
        if height > 200{
            return 1.0
        }else if height < 100{
            return 0.5
        }
        return Double(abs(height / 200))
    }
    func getColor (for height:CGFloat,full :CGFloat)-> Color{
        let index = Double(abs(height / full * 1.5 ))
        return withAnimation {
            Color(hue:index * 0.7,saturation:index * 1.2,brightness:index * 1.2)
        }
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
