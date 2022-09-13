//
//  ContentView.swift
//  ElSanto
//
//  Created by Fede Garcia on 16/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Image("candy")
                    .ignoresSafeArea()
               
                VStack{
                    
                 
                    
                        
                        
                                         
                    Spacer()
                    HStack{
                        NavigationLink {
                            Boletas()
                        } label: {
                            Text("Ingreso")
                                .padding()
                                .font(.title)
                            Image(systemName: "tray.and.arrow.down.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.green, .black)
                                .font(.system(size: 100))
                                .frame(width: 100, height: 100, alignment: .center)
                                .scaledToFill()
                        }
                            .frame(width: 300, height: 100, alignment: .center)
                            
                            .padding()
                            .background(.ultraThinMaterial)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack{
                        NavigationLink {
                            Historico()
                        } label: {
                            Text("Histórico")
                                .padding()
                                .font(.title)
                            Image(systemName: "tray.full.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, .black)
                                .font(.system(size: 100))
                                .frame(width: 100, height: 100, alignment: .center)
                                .scaledToFill()
                        }
                            .frame(width: 300, height: 100, alignment: .center)
                            .padding()
                            .background(.ultraThinMaterial)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    
                    HStack{
                        NavigationLink {
                            Precios()
                        } label: {
                            Text("Precios   ")
                                .padding()
                                .font(.title)
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.gray, .black)
                                .font(.system(size: 90))
                                .frame(width: 100, height: 100, alignment: .center)
                                .scaledToFill()
                                
                        }
                        .frame(width: 300, height: 100, alignment: .center)
                        .padding()
                        .background(.ultraThinMaterial)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    Spacer()
                }
        
                .navigationTitle("El Santo Maxikiosco")
                .foregroundColor(.black)
               
            }
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
