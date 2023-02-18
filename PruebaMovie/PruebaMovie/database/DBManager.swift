//
//  DBManager.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation
import CoreData

//Manejador que se encarga de crear la BD, asi como las operaciones a la tabla donde se almacenan las peliculas favoritas
class DBManager {
    private let container: NSPersistentContainer!
    
    init() {
        
        let momdName = "PruebaMovieDB"
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: momdName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        container = NSPersistentContainer(name: momdName, managedObjectModel: mom)
        
        localDataSource()
    }
    
    /// Crea y carga la BD para tenerla lista
    private func localDataSource() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                debugPrint("Error loading store \(desc) — \(error)")
                return
            }
            
            debugPrint("PruebaMovieDB ready!")
        }
    }
    
    func getFavoritesList(isFavorite: Bool) -> [FavoritesTable] {
        let fetchRequest : NSFetchRequest<FavoritesTable> = FavoritesTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite = %@", NSNumber(booleanLiteral: isFavorite))
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            debugPrint("Error obteniendo Movies \(error)")
        }
        
        return []
    }
    
    func getFavoriteById(movieId: Int) -> FavoritesTable? {
        let fetchRequest : NSFetchRequest<FavoritesTable> = FavoritesTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(movieId)")
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            
            return result.count == 0 ? nil : result.first
        } catch {
            debugPrint("Error obteniendo Movies \(error)")
        }
        
        return nil
    }
    
    func insertMovie(movie: Movie) {

        container.performBackgroundTask { (context) in
            let favoriteMovie = FavoritesTable(context: context)
            
            favoriteMovie.id = Int64(movie.id ?? 0)
            favoriteMovie.overview = movie.overview
            favoriteMovie.posterPath = movie.poster_path
            favoriteMovie.title = movie.title
            favoriteMovie.date = movie.release_date
            favoriteMovie.rate = movie.vote_average ?? 0
            favoriteMovie.isFavorite = movie.isFavorite ?? false
            
            do {
                try context.save()
                debugPrint("Movies guardada: \(favoriteMovie)")
            } catch {
                debugPrint("Error guardando movie — \(error)")
            }
        }
    }
    
    func updateFavorite(isFavorite: Bool, id: Int) {
        let context = container.viewContext
        let fetchRequest : NSFetchRequest<FavoritesTable> = FavoritesTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count != 0 {
                results[0].setValue(isFavorite, forKey: "isFavorite")
            }
            
            try context.save()
            debugPrint("favorito actualizado manager")
        } catch {
            debugPrint("Error al actualizar movie")
        }
    }
    
    /// Elimina por completo la informacion de la tabla
    func truncateTable() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritesTable")
                
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
        do {
            try context.execute(deleteRequest)
            print("Tabla limpia")
        } catch {
            print("Error al truncar — \(error)")
        }
    }
}
