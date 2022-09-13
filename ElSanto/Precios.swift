//
//  Precios.swift
//  ElSanto
//
//  Created by Fede Garcia on 27/08/2022.
//

import SwiftUI

struct Precios: View {
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    
    /// VARIABLES

    
    
    @State private var precioDeEntrada = 0.00
    @State private var categoriaSeleccionada = 0
    @State private var ivaSioNo = 0
    @State private var mostrarFinal : Bool = false
    @State private var precioFinalString : String = "Precio final: "
    @State private var numeroFinal : Double = 0
    
    let categorias = ["Golosinas", "Cigarrillos", "Bebidas", "Lay's"]
    let porcentajeCategorias = [1.80, 1.15, 2, 1.60]
    let conIvaoNo = ["Si", "No"]
   
    
    @FocusState var precioFocused : Bool
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                /// BACKGROUND COLOR--------------------------
            
                
                Image("matematica2").renderingMode(.original)
                    .resizable()
                .ignoresSafeArea()
                
                VStack{
                    
                    /// TITULO --------------------------
                    
                    
                    VStack{
                             Text("Precio Venta")
                             .font(.largeTitle.weight(.bold))
                             .foregroundColor(.white)
                    }
                    
                    /// FORMULARIO --------------------------
                    
                   
                    VStack{
                        Form {
                          
                            
                            Section {
                                
                                Picker("Categoria", selection: $categoriaSeleccionada){
                                    ForEach(0..<categorias.count){ categoria in
                                        Text (categorias[categoria])
                                    }
                                }
                                Picker("+ Iva", selection: $ivaSioNo){
                                    ForEach(0..<conIvaoNo.count){ categoria in
                                        Text (conIvaoNo[categoria])
                                    }
                                }
                                
                                TextField ("Precio de compra", value: $precioDeEntrada, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .keyboardType(.decimalPad)
                                    .focused($precioFocused)
                                    .multilineTextAlignment(.center)
                                                               
                            }
                             
                        }
                        .background(.clear)
                        .cornerRadius(15)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard){
                                Button("Done"){
                                    precioFocused = false
                                }
                            }
                        }
                        
                        Button(action: {
                            mostrarFinal.toggle()
                            mostrarPrecioFinal()
                        }, label: {
                            Text("Calcular")
                                .font(.headline)
                                .frame(height: 50)
                                .frame(width: 200)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                        })
                        .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))

                    }
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .center)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    
                    Spacer()

                }
                
                
            }
            .alert(precioFinalString, isPresented: $mostrarFinal){
                Button("Confirmar", action: resetearFormulario)
            } message: {
                Text("$ \(numeroFinal, specifier: "%.2f")").font(.largeTitle)
            }
            
        }
        
        
    }
    /// FUNCIONES --------------------------
    
    
    
    func mostrarPrecioFinal (){
        if ivaSioNo == 1 {
            numeroFinal = porcentajeCategorias[categoriaSeleccionada] * precioDeEntrada} else {numeroFinal = (porcentajeCategorias[categoriaSeleccionada] * precioDeEntrada) * 1.21}
    }
    func resetearFormulario(){
        precioDeEntrada = 0.00
        categoriaSeleccionada = 0
        ivaSioNo = 0
    }
    
}

struct Precios_Previews: PreviewProvider {
    static var previews: some View {
        Precios()
    }
}
