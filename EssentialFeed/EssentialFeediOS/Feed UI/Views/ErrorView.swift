//
//  ErrorView.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 17/09/25.
//
import UIKit

public final class ErrorView: UIView {
    @IBOutlet private var label: UILabel!
    
    public var message: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = nil
    }
}
