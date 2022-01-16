//
//  Extension.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

import UIKit

extension UIColor {
    
    // MARK:- variables
    static var titleColor = UIColor(named: "title-color")
    
    static var cardColor = UIColor(named: "card-color")
    
    static var bodyColor = UIColor(named: "body-color")
    
}

extension UIViewController {
    
    // MARK:- functions
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
}

extension String {
    
    // MARK:- variables
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}


extension UILabel {
    
    // MARK:- functions
    func setLineHeight(lineHeight: CGFloat) {
        guard let text = self.text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineHeight
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
    
}
