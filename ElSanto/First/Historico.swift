//
//  Historico.swift
//  ElSanto
//
//  Created by Fede Garcia on 27/08/2022.
//

import SwiftUI

struct Historico: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.fecha)]) var boletas: FetchedResults<Boleta>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @State private var total = 0.00
    
    
    var body: some View {
        
       
        
        VStack{
            
            
            
            List{
                
                 ForEach(boletas){ boleta in
                    
                    let date = boleta.fecha!
                    
                    HStack{
                        
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                        
                        Text(boleta.proveedor ?? "Unknown").multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Text("\(String(format: "%.2f", boleta.monto))").multilineTextAlignment(.trailing).foregroundColor(.red)
                        
                        
                        
                        
                    }
                }
                Text("Total: \(String(format: "%.2f", totales()))")
            }
            
        }
        .toolbar {
            ToolbarItemGroup{
                EditButton()
                
            }
            
        }
    }
    
    func totales() -> Double {
        
        var totales = 0.00
        
        
        
        for mont in boletas {
          
             totales =  totales + mont.monto
        
        }
        return totales
    }
    func guardarBoletas() {
        try? managedObjectContext.save()
    }
    func borrarBoletas(at offsets: IndexSet){
        for index in offsets {
            let boleta = boletas[index]
            managedObjectContext.delete(boleta)
            }
    }
}

struct Historico_Previews: PreviewProvider {
    static var previews: some View {
        Historico()
    }
}
