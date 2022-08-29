//
//  ViewModelList.swift
//  MVVMAppv2
//
//  Created by usuario on 26/8/22.
//

import Foundation

class ViewModelList {

    //CREAR UN MECANISMO PARA ENLAZAR LA VISTA CON EL MODELO DE LA VISTA

    var refreshData = { () -> () in }

    //FUENTE DE DATOS (ARRAY)

    var dataArray: [List] = [] {
        didSet {
            refreshData()
        }
    }

    //OBTENER LOS DATOS DE LA API (NO DEBERIA ESTAR AQUI)

    func retriveDataList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let json = data else { return }

            //SERIALIZAR LOS DATOS

            do {
                let decoder = JSONDecoder()
                self.dataArray = try decoder.decode([List].self, from: json)
            } catch let error {
                print("Error sucssed: \(error.localizedDescription)")
            }
        } .resume()
    }


}
