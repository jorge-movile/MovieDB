//
//  DateTimeFunctions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation

//Clase con una funcion para convertir de un tipo de fecha a otro
public class DateTimeFunctions {
    
    public static func dateFormat(dateString: String, inputFormat: String, outputFomrat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputFomrat
            
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}
