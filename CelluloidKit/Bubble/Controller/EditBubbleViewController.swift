//
//  EditBubbleViewController.swift
//  Celluloid
//
//  Created by Mango on 16/3/12.
//  Copyright © 2016年 Mango. All rights reserved.
//

import UIKit
import SnapKit

public protocol EditBubbleViewControllerDelegate: class {
    func editBubbleViewController(editBubbleViewController: EditBubbleViewController, didEditedBubbleModel bubbleModel: BubbleModel)
    
}

public class EditBubbleViewController: UIViewController {
    
    //MARK: Property
    var bubbleModel: BubbleModel
    
    public weak var delegate: EditBubbleViewControllerDelegate?
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .Center
        textView.text = self.bubbleModel.content
        return textView
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(title: tr(.Done), style: .Plain, target: self, action: #selector(EditBubbleViewController.done))
        return rightBarButtonItem
    }()
    
    //MARK: init
    public init(bubbleModel:BubbleModel){
        self.bubbleModel = bubbleModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.textView)
        self.textView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(textView.superview!)
        }
        
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
    }
}

//MARK: Action
private extension EditBubbleViewController {
    @objc func done(){
        self.bubbleModel.content = self.textView.text
        self.delegate?.editBubbleViewController(self, didEditedBubbleModel: self.bubbleModel)
        dismissViewControllerAnimated(true, completion: nil)
    }
}