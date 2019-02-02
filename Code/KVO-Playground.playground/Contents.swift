import Foundation

//
//
//

public class Usuario: NSObject
{
    /// Nombre del usuario.
    /// Propiedad de la que queremos saber sus cambios
    @objc dynamic public var nombre: String
    
    /**
        Creamos un nuevo usuario
    */
    public init(named nombre: String)
    {
        self.nombre = nombre
        
        super.init()
    }
}

//
// MARK: - El Observador
//

public class Observador: NSObject
{
    /// Nada interesante que inicializar
    override public init()
    {
        print("Soy el observador")
    }
    
    /**
        Aquí se nos notifican los cambios
    */
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        guard let keyPath = keyPath,  let change = change else
        {
            return
        }
        
        if let newName = change[NSKeyValueChangeKey.newKey], let oldName = change[NSKeyValueChangeKey.oldKey]
        {
            print("La propiedad con el keyPath '\(keyPath)' antes era \(oldName) y ahora tiene el valor \(newName)")
        }
    }
}

// Creamos un usuario...
let usuario = Usuario(named: "root")
// ...y un observador
let observer = Observador()

// El usuario registar un observador.
// Va a estar al tanto de los cambios en la propiedad `nombre`
// Se le pasa el valor que tenía antes (.old) y el nuevo (.new)
usuario.addObserver(observer, forKeyPath: #keyPath(Usuario.nombre), options: [ .new, .old ], context: nil)

// Al cambiar el nombre el obsevador será informado del cambio
usuario.nombre = "regular user"
