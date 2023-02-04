//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 16.11.22.
//

import UIKit
import SnapKit

public class PrimaryButtonControl: UIControl {
    private  var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private  var lbl: UILabel = {
        let txt = UILabel()
        txt.backgroundColor = .white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private  var leftIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private  var rightIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        constrain()
    }
    
    public init(with model: Model? = nil) {
        super.init(frame: .zero)
        guard let model = model else {
            constrain()
            return
        }
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Model) {
    }
    
    private func constrain() {
        self.addSubview(stack)
        stack.addArrangedSubview(leftIcon)
        stack.addArrangedSubview(lbl)
        stack.addArrangedSubview(rightIcon)
        
        stack.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
}
