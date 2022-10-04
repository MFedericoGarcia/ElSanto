//
//  Historico.swift
//  ElSanto
//
//  Created by Fede Garcia on 27/08/2022.
//

import SwiftUI

struct Historico: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.fecha, order: .reverse)]) var boletas: FetchedResults<Boleta>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @State private var total = 0.00
    @State private var meslegido = Date()
    
    var body: some View {
        
       
        
        VStack{
            
            
            List{
                
                ForEach(boletas){ boleta in
                    
                    
                    let date = boleta.fecha!
                    
                    HStack{
                        
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(boleta.proveedor ?? "Unknown").multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                       
                        
                        
                        Text("\(String(format: "%.2f", boleta.monto))").multilineTextAlignment(.trailing).foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        
                        
                    }
                    
                }
                .onDelete(perform: borrarBoletas)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Spacer()
            Text("Total: \(String(format: "%.2f", totales()))").multilineTextAlignment(.center)
            
        }
        
    }
    
    func totales() -> Double {
        
        var totales = 0.00
        
        
        
        for mont in boletas {
          
             totales =  totales + mont.monto
        
        }
        return totales
    }
    
    func borrarBoletas(at offsets: IndexSet){
        for index in offsets {
            let boleta = boletas[index]
            managedObjectContext.delete(boleta)
            }
        try? managedObjectContext.save()
    }
}

struct Historico_Previews: PreviewProvider {
    static var previews: some View {
        Historico()
    }
}
