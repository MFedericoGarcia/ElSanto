//
//  NuevoProducto.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/09/2022.
//

import SwiftUI

struct NuevoProducto: View {
    var body: some View {
            
            ZStack{
                
                Image("boxes")
                    .renderingMode(.original)
                    .resizable()
                .ignoresSafeArea()
                
                
                
                VStack{
                    HStack{
                        NavigationLink {
                            IngresoProducto()
                        } label: {
                            Text("Ingreso")
                                .padding()
                                .font(.title)
                            Image(systemName: "text.badge.plus")
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
                    HStack{
                        NavigationLink {
                            Lista()
                        } label: {
                            Text("Lista")
                                .padding()
                                .font(.title)
                            Image(systemName: "list.number")
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
                        
                }
            }
        
    }
}

struct NuevoProducto_Previews: PreviewProvider {
    static var previews: some View {
        NuevoProducto()
    }
}
