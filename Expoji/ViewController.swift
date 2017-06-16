//
//  ViewController.swift
//  Exploji
//
//  Created by Yariv on 6/16/17.
//  Copyright © 2017 Yariv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var button: UIButton!

    @IBAction private func launch(_ sender: Any) {
        fadeOut {
            self.exploji()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    private var emojiViews: [UIView] = []
    
    private func fadeOut(completion: @escaping (Void) -> ()) {
        if emojiViews.isEmpty {
            completion()
            return
        }
        let views = emojiViews
        emojiViews = []
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            views.forEach { $0.alpha = 0 }
        }) { (_) in
            views.forEach { $0.removeFromSuperview() }
        }
        completion()
    }
    
    private func exploji() {
        for _ in 1...12 {
            let emoji = self.createEmoji()
            self.emojiViews.append(emoji)
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 5, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.emojiViews.forEach {
                $0.center = self.randomPoint()
            }
        }, completion: nil)
    }
    
    private func randomPoint() -> CGPoint {
        let angle = CGFloat(arc4random_uniform(360))
        let x = cos(angle) * view.frame.width*2
        let y = sin(angle) * view.frame.height*2
        return CGPoint(x: x, y: y)
    }
    
    private func createEmoji() -> UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let emojis = ["👮","👨‍🏫","🐹","🐷","🐽","🐛","🐃","🦂","🕸","🐙","🦍","🌊","⚡️","🌔","🌩","🍚","🌽","🥐","🍣","🍦","🍵","🍩","🍫"]
        let index = Int(arc4random_uniform(UInt32(emojis.count)))
        label.text = emojis[index]
        label.font = UIFont.systemFont(ofSize: 40)
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
        return label
    }
}

