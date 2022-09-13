//
//  Boletas.swift
//  ElSanto
//
//  Created by Fede Garcia on 27/08/2022.
//

import SwiftUI

struct Boletas: View {
    
    @State private var proveedores = [1, 2, 3, 4, 5 ,6]
    @State private var proveedoresNombres : [String] = ["Osle", "Coca-Cola", "Palco", "Pepsico", "Nobleza Picardo", "Mondelez", "Aguas Danone", "Pepsi", "Massalin Particulares"]
    let facturacionABC = ["'A'", "'B'", "'C'", "Consumidor Final"]
    
    @State private var proveedorSeleccionado = 0
    @State private var facturacionSeleccionada = 0
    @State private var fechaSeleccionada = Date()
    @State private var montoSeleccionado = 0.00
    @FocusState private var submit : Bool
    @State private var boletasIngresadas = [String]()
    @State private var nombreNuevoProveedor: String = ""
    @State private var showingSheet: Bool = true
    @State private var proveedorAgregado : String = "Proveedor agregado"
    @State private var mostrarFinal : Bool = false
    
    var nombreProveedor : String{
        let proveedorSelection = proveedoresNombres[proveedorSeleccionado]
        return proveedorSelection
    }
    
    var tipoDeFacturacion : String {
        let tipo = facturacionABC[facturacionSeleccionada]
        return tipo
    }
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    
  
    
    var body: some View {
        
        
        
        
        NavigationView {
            
            
            
            ZStack{
                
                Image("papeles")
                    .renderingMode(.original)
                    .resizable()
                .ignoresSafeArea()
                
                if showingSheet {
                
                VStack{
                    
                    
                
                    VStack{
                             Text("Ingreso boletas")
                             .font(.largeTitle.weight(.bold))
                             .foregroundColor(.black)
                             .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                             
                             
                             
                             
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                    VStack{
                        
                        
                        Form(){
                            Section{
                                Picker("Proveedor", selection: $proveedorSeleccionado){
                                    ForEach (0..<proveedoresNombres.count) { index in
                                        Text("\(proveedoresNombres[index])")
                                    }
                                }
                                Picker("Tipo de Facturación", selection: $facturacionSeleccionada){
                                    ForEach(0..<facturacionABC.count){ index in
                                        Text("\(facturacionABC[index])")
                                    }
                                   
                                }
                                DatePicker(selection: $fechaSeleccionada, in: ...Date(), displayedComponents: .date)
                                {Text("Fecha")
                                }
                                TextField ("monto", value: $montoSeleccionado, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.center)
                                    .focused($submit)
                                
            
                            }
                        
                            
                        header: {
                            Text("Ingreso").foregroundColor(Color.black)
                        }
                        
                        }
                        .background(.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .keyboard){
                                Button("Done"){
                                    submit = false
                                }
                            }
                        }
                        Button(action: {
                            let answer1 = proveedoresNombres[proveedorSeleccionado]
                            let answer2 = montoSeleccionado
                            
                            let answer = "\(answer1)   $\(answer2)"
                            
                            boletasIngresadas.append(answer)
                            reiniciarContadores()
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
                        .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))
                        
                        
                    }
                    .frame(height: 350)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    Form{
                        Section{
                            List{
                                ForEach(boletasIngresadas, id:\.self) {
                                    
                                        Text("\($0)")}
                                
                                .onDelete(perform: removeRows)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .background(.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.init(top: 0, leading: 10, bottom: 40, trailing: 10))
                }
                }
                else {
                    VStack{
                        
                        
                    
                        VStack{
                                 Text("Ingreso boletas")
                                 .font(.largeTitle.weight(.bold))
                                 .foregroundColor(.black)
                                 .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                 
                                 
                                 
                                 
                        }
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                        VStack{
                            
                            
                            Form(){
                                Section{
                                    
                                    TextField("Nuevo proveedor", text: $nombreNuevoProveedor)
                                        .focused($submit)
                                    Button(action: nuevoProveedor2, label: {
                                        Text("Agregar")
                                    })
                                    .disabled(nombreNuevoProveedor.isEmpty)
                                    
                                    Picker("Proveedor", selection: $proveedorSeleccionado){
                                        ForEach (0..<proveedoresNombres.count) { index in
                                            Text("\(proveedoresNombres[index])")
                                        }
                                    }
                                    Picker("Tipo de Facturación", selection: $facturacionSeleccionada){
                                        ForEach(0..<facturacionABC.count){ index in
                                            Text("\(facturacionABC[index])")
                                        }
                                       
                                    }
                                    DatePicker(selection: $fechaSeleccionada, in: ...Date(), displayedComponents: .date)
                                    {Text("Fecha")
                                    }
                                    TextField ("monto", value: $montoSeleccionado, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .keyboardType(.decimalPad)
                                        .multilineTextAlignment(.center)
                                        .focused($submit)
                                    
                
                                }
                            
                                
                            header: {
                                Text("Ingreso").foregroundColor(Color.black)
                            }
                            
                            }
                            .background(.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .toolbar {
                                
                                ToolbarItemGroup(placement: .keyboard){
                                    Button("Done"){
                                        submit = false
                                    }
                                }
                            }
                            Button(action: {
                                let answer1 = proveedoresNombres[proveedorSeleccionado]
                                let answer2 = montoSeleccionado
                                
                                let answer = "\(answer1)   $\(answer2)"
                                
                                boletasIngresadas.append(answer)
                                reiniciarContadores()
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
                            .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))
                            
                            
                        }
                        .frame(height: 450)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Form{
                            Section{
                                List{
                                    ForEach(boletasIngresadas, id:\.self) {
                                        
                                            Text("\($0)")}
                                    
                                    .onDelete(perform: removeRows)
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.init(top: 0, leading: 10, bottom: 40, trailing: 10))
                    }
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: nuevoProveedor, label:{ Text("Nuevo Proveedor").foregroundColor(.blue).shadow(color: .black, radius: 10, x: 0, y: 10);
                        Image(systemName: "person.crop.circle.badge.plus")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.blue)
                            .font(.system(size: 25))
                    })
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    

                        }
                    }
            .alert(proveedorAgregado, isPresented: $mostrarFinal){
                Button("Confirmar", action: alerta)
            }
        }
        
        
        
    }
    
    func alerta(){

        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
        showingSheet.toggle()
        }
    }
    
    func nuevoProveedor(){
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
        showingSheet.toggle()
        }
        
    }
    
    func nuevoProveedor2 (){
        
       
        
        mostrarFinal.toggle()
        proveedoresNombres.append(nombreNuevoProveedor)
        proveedores.append(proveedores.count+2)
        
        nombreNuevoProveedor = ""
        
    }
    
    func agregarBoleta(at offsets: IndexSet){
        
        let answer1 = proveedoresNombres[proveedorSeleccionado]
        let answer2 = montoSeleccionado
        
        let answer = "\(answer1)   $\(answer2)"
        withAnimation{
            boletasIngresadas.append(answer)
        }
        
    }
    func reiniciarContadores(){
        proveedorSeleccionado = 0
        montoSeleccionado = 0
        fechaSeleccionada = Date()
        facturacionSeleccionada = 0
    }
    func removeRows(at offsets: IndexSet){
        boletasIngresadas.remove(atOffsets: offsets)
    }
}

struct Boletas_Previews: PreviewProvider {
    static var previews: some View {
        Boletas()
    }
}
