//
//  IngresoProducto.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/09/2022.
//

import SwiftUI

struct Producto: Identifiable, Hashable{
    let id: Int
    var nombre: String
    var precioEntrada: Double
    var masIva: Bool
    var categoria: Int
    
}

struct Categoria: Identifiable{
    let id: Int
    var nombre: String
}




struct IngresoProducto: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.categoria), SortDescriptor(\.nombre)]) var productos2: FetchedResults<Productos>
    @Environment(\.managedObjectContext) var moc
    
    
    @State private var categorias = ["Bebidas", "Varios", "Cigarrillos", "Tabacos"]
    
    @State private var productos = [
        Producto(id: 1, nombre: "Coca-Cola 600mL", precioEntrada: 95, masIva: true, categoria: 0),
        Producto(id: 2, nombre: "Sprite 1.5L", precioEntrada: 94, masIva: false, categoria: 0),
        Producto(id: 3, nombre: "BonoBon", precioEntrada: 30, masIva: true,  categoria: 1),
        Producto(id: 4, nombre: "Beldent", precioEntrada: 99, masIva: true, categoria: 1),
        Producto(id: 5, nombre: "Marlboro Box", precioEntrada: 150, masIva: false, categoria: 3)
    ]
    
    /// ARMADOR DE PRODUCTO
    @State private var nombreProductoNuevo: String = ""
    @State private var precioEntradaNuevo = 0.00
    @State private var categoriaNuevo = 0
    
    @FocusState var precioFocused : Bool
    
    @State private var masIva: Bool = false
    @State private var mostrarError : Bool = false
    let error = "Ingresar Nombre del Producto"
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }

    
    var body: some View {

        ZStack{
            
            Image("caramelera")
                .renderingMode(.original)
                .resizable()
            .ignoresSafeArea()
            
            VStack{
                
            
                VStack{
                    
                    Form {
                        Section{
                            TextField("Nombre del producto", text: $nombreProductoNuevo)
                                .focused($precioFocused)
                                .multilineTextAlignment(.center)
                                
                            Picker("Categoria", selection: $categoriaNuevo){
                                ForEach(0..<categorias.count, id: \.self){
                                    index in
                                    Text("\(categorias[index])")
                                }
                            }
                            TextField("Precio de entrada", value: $precioEntradaNuevo, format: .currency(code: Locale.current.currencyCode ?? "USD" ))
                                .keyboardType(.decimalPad)
                                .focused($precioFocused)
                                .multilineTextAlignment(.center)
                            Toggle("+Iva", isOn: $masIva)
                            
                            Button(action: {
                                if nombreProductoNuevo == ""{
                                    mostrarError.toggle()
                                } else {
                                 
                                    agregarABaseDeDatos()
                                    ingresarProducto()
                                }
                            }, label: {
                                Text("Ingresar")
                                    .font(.headline)
                                    .frame(height: 50)
                                    .frame(width: 200)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                                
                            })
                            .multilineTextAlignment(.center)
                            .padding(.init(top: 10, leading: 50, bottom: 20, trailing: 50))
                        }
                        
                    header: {
                        Text("Ingreso").foregroundColor(Color.black)
                    }
                    }
                    .frame(height: 335)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                   
                    
                }
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard){
                        Button("Done"){
                            precioFocused = false
                        }
                    }
                
                }
                
                VStack{
                    
                     Form{
                         Section{
                             List{
                                 ForEach(productos, id: \.id){ nombre in
                                    
                                     HStack{
                                         Text("\(nombre.nombre)")
                                             .multilineTextAlignment(.leading)
                                         
                                         Spacer()
                                         Spacer()
                                         Image(systemName: "square.and.arrow.down")
                                             .foregroundColor(.green)
                                         Text("$ \(String(format: "%.2f", nombre.precioEntrada))")
                                             .foregroundColor(.green)
                                             .multilineTextAlignment(.trailing)
                                         
                                         
                                         if nombre.masIva.description.isEmpty {
                                             
                                             Text("$ \(calcularVenta(entrada: nombre.precioEntrada ,categoria: nombre.categoria, iva: masIva))")
                                                 .multilineTextAlignment(.trailing)
                                                 .foregroundColor(.red)
                                             
                                         }else {
                                             Text("$ \(calcularVenta(entrada: nombre.precioEntrada ,categoria: nombre.categoria, iva: nombre.masIva))")
                                                 .multilineTextAlignment(.trailing)
                                                 .foregroundColor(.red)
                                         }
                                         Image(systemName: "square.and.arrow.up")
                                             .foregroundColor(.red)
                                        
                                     }
                                    
                                     
                                 }
                                 .onDelete(perform: removeRows)
                             }
                             
                         }
                     }
                     .cornerRadius(15)
                     
                     
                }
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
               
                
            }
            
            
            
            
        }
        .alert(error, isPresented: $mostrarError){
            Button("Confirmar"){
                
            }
        }
        
    }
    
    func ingresarProducto(){
        let id = productos.count+2
        let nombre = nombreProductoNuevo
        let precio = precioEntradaNuevo
        let categoria = categoriaNuevo
        let masIvasm = masIva
        let nuevoProducto = Producto(id: id.self, nombre: nombre.self, precioEntrada: precio.self, masIva: masIvasm.self, categoria: categoria.self)
       
            withAnimation{
                productos.insert(nuevoProducto, at: 0)
            }
        
        borrado()
    }
    func alerta(){
        mostrarError.toggle()
    }
    func borrado(){
        nombreProductoNuevo = ""
        precioEntradaNuevo = 0.00
        categoriaNuevo = 0
    }
    func calcularVenta(entrada: Double, categoria: Int, iva: Bool) -> String {
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
    func removeRows(at offsets: IndexSet){
        
        /// ACA HAY QUE HACER ALGO
        ///
        ///
        ///
        /// 
        productos.remove(atOffsets: offsets)
    }
    
    func agregarABaseDeDatos(){
        
        
        let nombre = nombreProductoNuevo
        let precio = precioEntradaNuevo
        let categoria = categoriaNuevo
        let iva = masIva
        
        let producto2 = Productos(context: moc)
        
        producto2.nombre = nombre
        producto2.precio = precio
        producto2.categoria = Int64(categoria)
        producto2.iva = iva
        producto2.id = UUID()
        
        try? moc.save()
        
        
    }
    
}


struct IngresoProducto_Previews: PreviewProvider {
    static var previews: some View {
        IngresoProducto()
    }
}
