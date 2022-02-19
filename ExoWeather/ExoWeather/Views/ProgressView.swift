//
//  ProgressView.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation
import UIKit

final class ProgressView: UIView {

    @IBInspectable var color: UIColor = .systemBlue {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var gradientColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    // This view will mask the percentage width
    private let maskedView = UIView()

    // So we can calculate the new-progress-animation duration
    private var currentProgress: CGFloat = 0.0

    public var progress: CGFloat = 0 {
        didSet {
            // calculate the change in progress
            let changePercent = abs(currentProgress - progress)

            // if the change is 100% (i.e. from 0.0 to 1.0),
            //  we want the animation to take 1-second
            //  so, make the animation duration equal to
            //  1-second * changePercent
            let duration = changePercent * 1.0
            // save the new progress
            currentProgress = progress

            // calculate the new width of the mask view
            var width = bounds
            width.size.width *= progress

            // animate the size of the mask-view
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                self.maskedView.frame = width
            })
        }
    }

    private var gradientLayer: CAGradientLayer!

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {

        // use self.layer as the gradient layer
        gradientLayer = self.layer as? CAGradientLayer
        gradientLayer.colors = [color.cgColor, gradientColor.cgColor]
        gradientLayer.locations =  [0.0, 0.95, 1.5]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.autoreverses = true
        maskedView.backgroundColor = .lightGray
        mask = maskedView

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // if the mask view frame has not been set at all yet
        if maskedView.frame.height == 0 {
            var customBounds = bounds
            customBounds.size.width = 0.0
            maskedView.frame = customBounds
        }

        gradientLayer.colors = [color.cgColor, gradientColor.cgColor, color.cgColor]
        layer.cornerRadius = bounds.height/2
    }

}
