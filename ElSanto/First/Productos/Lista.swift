//
//  Lista.swift
//  ElSanto
//
//  Created by Fede Garcia on 23/09/2022.
//

import SwiftUI

struct Lista: View {
    
   @FetchRequest(sortDescriptors: [SortDescriptor(\.categoria), SortDescriptor(\.nombre)]) var productos: FetchedResults<Productos>
   @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var categorias = ["Bebidas", "Varios", "Cigarrillos", "Tabacos"]
    
    var body: some View {
        HStack{
            
            
            VStack{
                
                List{
                    ForEach(productos){ producto in
                        
                        let precioVenta = calcularVenta(entrada: producto.precio, categoria: producto.categoria, iva: producto.iva)
                        let precioString = String(format: "%.2f", producto.precio)
                        
                        HStack{
                            
                            Text(producto.nombre ?? "Sin nombre")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(precioString).foregroundColor(.green)
                                .frame(maxWidth: .infinity, alignment: .center)
                           
                           
                            Text(precioVenta).font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        
                    }
                    .onDelete(perform: borrarProducto)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }

           }
        }
    }
    
    func calcularVenta(entrada: Double, categoria: Int64, iva: Bool) -> String {
            let precioEntrada = entrada
            var categoriaSeleccionada = 0.0
            var conIva = 1.0
            
        if categoria == 0 {
            categoriaSeleccionada = 2
            } else if categoria == 1{
                categoriaSeleccionada = 1.8
            } else if categoria == 2{
                categoriaSeleccionada = 1.015
            } else {
                categoriaSeleccionada =  1.7
            }
            
        if iva {
            conIva = 1.21
        }
        
            let precioSalida = ((precioEntrada)*conIva)*Double(categoriaSeleccionada)
        return String(format: "%.2f", precioSalida)
       
    }
    
    func borrarProducto(at offsets: IndexSet){
        for index in offsets {
            let producto = productos[index]
            managedObjectContext.delete(producto)
            }
        try? managedObjectContext.save()
    }
    
}

struct Lista_Previews: PreviewProvider {
    static var previews: some View {
        Lista()
    }
}
