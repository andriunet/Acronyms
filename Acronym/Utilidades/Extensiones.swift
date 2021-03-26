//
//  Extensiones.swift
//  Acronym
//
//  Created by Andres Marin on 26/03/21.
//

import UIKit

extension UITableView {

    func setMensajeVacio() {
        let lblMensaje = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMensaje.text = "Enter an acronym or initialism"
        lblMensaje.textColor = self.tintColor
        lblMensaje.numberOfLines = 0
        lblMensaje.textAlignment = .center
        lblMensaje.font = UIFont(name: "System", size: 25)
        lblMensaje.sizeToFit()

        self.backgroundView = lblMensaje
        self.separatorStyle = .none
    }

    func restaurar() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}

extension UISearchBar {
    
    public var activityIndicator: UIActivityIndicatorView? {
        return self.searchTextField.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }

    var cargando: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .large)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    newActivityIndicator.startAnimating()
                    
                    //Detectamos si esta en modo dark o no.
                    if self.traitCollection.userInterfaceStyle == .dark {
                        newActivityIndicator.backgroundColor = #colorLiteral(red: 0.1097861007, green: 0.1097446457, blue: 0.1183722988, alpha: 1)
                    } else {
                        newActivityIndicator.backgroundColor = #colorLiteral(red: 0.9332494736, green: 0.9333527684, blue: 0.9375279546, alpha: 1)
                    }
                    
                    self.searchTextField.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = self.searchTextField.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}


