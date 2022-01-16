//
//  NetworkModelDelegate.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

protocol NetworkModelDelegate: AnyObject {
    func reloadTable()
    func error(message: String)
}
