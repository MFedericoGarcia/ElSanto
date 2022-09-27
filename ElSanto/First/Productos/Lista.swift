//
//  Lista.swift
//  ElSanto
//
//  Created by Fede Garcia on 23/09/2022.
//

import SwiftUI

struct Lista: View {
    
   /// @FetchRequest(sortDescriptors: [SortDescriptor(\.categoria), SortDescriptor(\.nombre)]) var productos: FetchedResults<Productos>
   /// @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack{
//            List{
////                ForEach(productos){ producto in
////
////
////                    HStack{
////                        Text(producto.nombre ?? "Sin nombre")
////                        Text(producto.categoria ?? "Sin categoria")
////                        Text(String(producto.precioEntrada))
////
////
////                    }
//
//
//                }
     ///       }
        }
    }
}

struct Lista_Previews: PreviewProvider {
    static var previews: some View {
        Lista()
    }
}
