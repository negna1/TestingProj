//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 16.11.22.
//

import UIKit

extension PrimaryButtonControl {
    public struct Model:  Hashable {
        public static func == (lhs: PrimaryButtonControl.Model, rhs: PrimaryButtonControl.Model) -> Bool {
            lhs.textType == rhs.textType
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(textType)
         }
        
        public var textType: BorderedTextField.TextType = .name
        public var placeHolder: String?
        public var didChangeText: ((BorderedTextField.TextType, String) -> ())?
        
        public init(textType: BorderedTextField.TextType = .name,
                    placeHolder: String? = nil,
         didChangeText: ((BorderedTextField.TextType, String) -> ())?) {
            self.placeHolder =  placeHolder ?? textType.rawValue
            self.textType = textType
            self.didChangeText = didChangeText
        }
    }
}

public struct TextStyleModel {
    public init(text: String, color: UIColor? = nil, font: UIFont? = nil) {
        self.text = text
        self.color = color
        self.font = font
    }
    
    let text: String
    let color: UIColor?
    let font: UIFont?
}
