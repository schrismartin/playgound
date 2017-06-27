//
//  IndicatorView.swift
//  Syllabus
//
//  Created by Chris Martin on 1/17/17.
//  Copyright © 2017 Chris Martin. All rights reserved.
//

import UIKit

protocol IndicatorViewDelegate: class {
    
    func numberOfRings(for indicatorView: IndicatorView) -> Int
    func indicatorView(_ indicatorView: IndicatorView, valueForRingAtIndex index: Int) -> Double
    func indicatorView(_ indicatorView: IndicatorView, colorForRingAtIndex index: Int) -> UIColor
    func spacingBetweenRings(for indicatorView: IndicatorView) -> CGFloat
    func indicatorView(_ indicatorView: IndicatorView, ringWidthAtIndex index: Int) -> CGFloat
    
}

extension IndicatorViewDelegate {
    
    func indicatorView(_ indicatorView: IndicatorView, colorForRingAtIndex index: Int) -> UIColor {
        return indicatorView.ringColor
    }
    
    func spacingBetweenRings(for indicatorView: IndicatorView) -> CGFloat {
        return indicatorView.spacing
    }
    
    func indicatorView(_ indicatorView: IndicatorView, ringWidthAtIndex index: Int) -> CGFloat {
        return indicatorView.ringWidth
    }
    
}

class IndicatorView: UIView {
    
    private let π = CGFloat(M_PI)
    
    public weak var delegate: IndicatorViewDelegate? {
        didSet { updateCircles() }
    }
    
    public var ringColor = UIColor.black
    public var spacing: CGFloat = 12
    public var ringWidth: CGFloat = 5
    public var hasGuidelines = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    func configure() {
        backgroundColor = .clear
    }
    
    func getArcLength(at index: Int) -> Double? {
        guard let arcLength = delegate?.indicatorView(self, valueForRingAtIndex: index) else { return nil }
        return arcLength > 1
            ? 1
            : arcLength
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let numRings = delegate?.numberOfRings(for: self) else { return }
        
        for index in 0..<numRings {
            
            guard let arcLength = getArcLength(at: index) else { return }
            
            if hasGuidelines {
                createGuideCircle(at: index)
            }
            
            createMainCircle(at: index, arcLength: arcLength)
            drawDot(at: index, at: .start, arcLength: arcLength)
            drawDot(at: index, at: .end, arcLength: arcLength)
            
        }
        
    }
    
    private func createGuideCircle(at index: Int) {
        let spacing = delegate?.spacingBetweenRings(for: self) ?? self.spacing
        
        let arcWidth: CGFloat = 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let diameter: CGFloat = max(bounds.width, bounds.height) - CGFloat(index) * spacing * 2
        
        let mainArcWidth = delegate?.indicatorView(self, ringWidthAtIndex: index) ?? ringWidth
        
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat = 5 * π / 2
        
        let path = UIBezierPath(arcCenter: center,
                                radius: diameter/2 - mainArcWidth / 2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        UIColor.white.withAlphaComponent(0.1).setStroke()
        path.stroke()
        
    }
    
    private func createMainCircle(at index: Int, arcLength: Double) {
        let arcWidth = delegate?.indicatorView(self, ringWidthAtIndex: index) ?? ringWidth
        let spacing = delegate?.spacingBetweenRings(for: self) ?? self.spacing
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let diameter: CGFloat = max(bounds.width, bounds.height) - CGFloat(index) * spacing * 2
        
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat = π / 2 + (2 * π) * CGFloat(arcLength)
        
        let path = UIBezierPath(arcCenter: center,
                                radius: diameter/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        delegate?.indicatorView(self, colorForRingAtIndex: index).setStroke()
        path.stroke()
    }
    
    private func drawDot(at index: Int, at location: DotLocation, arcLength: Double) {
        let arcWidth = delegate?.indicatorView(self, ringWidthAtIndex: index) ?? ringWidth
        let spacing = delegate?.spacingBetweenRings(for: self) ?? self.spacing
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let diameter: CGFloat = max(bounds.width, bounds.height) - CGFloat(index) * spacing * 2
        
        let newPosition: CGFloat = location == .start
            ? π / 2
            : π / 2 + (2 * π) * CGFloat(arcLength)
        
        let newCenter = CGPoint(x: center.x + (diameter / 2 - arcWidth / 2) * cos(newPosition),
                                y: center.y + (diameter / 2 - arcWidth / 2) * sin(newPosition))
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat = 5 * π / 2
        
        let path = UIBezierPath(arcCenter: newCenter,
                                radius: arcWidth / 2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        delegate?.indicatorView(self, colorForRingAtIndex: index).setFill()
        path.fill()
    }
    
    public func updateCircles() {
        self.setNeedsDisplay()
    }
    
    enum DotLocation {
        case start
        case end
    }
    
}

class GradeDisplay: UIView, IndicatorViewDelegate {
    
    var numItems = 3
    static var margins: CGFloat = 10
    
    internal func indicatorView(_ indicatorView: IndicatorView, valueForRingAtIndex index: Int) -> Double {
        return 0.5
    }

    
    internal func numberOfRings(for indicatorView: IndicatorView) -> Int {
        return 3
    }
    
    func indicatorView(_ indicatorView: IndicatorView, colorForRingAtIndex index: Int) -> UIColor {
        return UIColor.cyan
    }
    
    func indicatorView(_ indicatorView: IndicatorView, ringWidthAtIndex index: Int) -> CGFloat {
        return 5
    }
    
    lazy var indicator: IndicatorView = {
        let offset: CGFloat = 13
        let dimension = self.frame.height - (2 * offset)
        
        let frame = CGRect(x: offset, y: offset, width: dimension, height: dimension)
        let view = IndicatorView(frame: frame)
        view.delegate = self
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Draw circle
        drawBackgroundCircle(in: rect)
        drawIndicators(in: rect)
    }
    
    func drawBackgroundCircle(in rect: CGRect) {
        let circleFrame = CGRect(x: 0, y: 0, width: rect.height, height: rect.height)
        let circlePath = UIBezierPath(ovalIn: circleFrame)
        
        let backgroundColor = UIColor.white.withAlphaComponent(0.2)
        backgroundColor.setFill()
        circlePath.fill()
    }
    
    func applyCircleMask(to rect: CGRect) {
        let maskFrame = CGRect(
            x: -GradeDisplay.margins,
            y: -GradeDisplay.margins,
            width: rect.height + (2 * GradeDisplay.margins),
            height: rect.height  + (2 * GradeDisplay.margins)
        )
        
        let canvasPath = UIBezierPath(rect: rect)
        let circleMask = UIBezierPath(ovalIn: maskFrame)
        canvasPath.append(circleMask)
        canvasPath.usesEvenOddFillRule = true
        
        canvasPath.addClip()
    }
    
    func drawIndicators(in rect: CGRect) {
        applyCircleMask(to: rect)
        
        //        let rightShift: [CGFloat] = [5, 0, 5]
        for iteration in 0 ..< numItems {
            
            // Calculate insets for indicators
            var insets = UIEdgeInsets(
                top: GradeDisplay.margins / 2,
                left: rect.height/2,
                bottom: GradeDisplay.margins / 2,
                right: 0
            )
            
            // Set up multipliers
            let shift = CGFloat(iteration)
            let height = rect.height / CGFloat(numItems) - insets.top - insets.bottom
            
            // Determine right inset
            let yPos = (shift + 1) * insets.top + shift * insets.bottom + shift * height
            let centerPos = yPos + height / 2
            let multiplier = cos(rect.height / 2 - centerPos)
            
            // Create frame for indicator
            let frame = CGRect(
                x: insets.left,
                y: yPos,
                width: rect.width - insets.left - insets.right - (1-multiplier) * (rect.height / 4),
                height: height
            )
            
            // Draw indicator
            drawIndicator(in: frame)
        }
        
    }
    
    func drawIndicator(in rect: CGRect) {
        let background = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        
        let color = UIColor.white.withAlphaComponent(0.2)
        color.setFill()
        
        background.fill()
    }
}

let frame = CGRect(x: 0, y: 0, width: 430, height: 300)
let view = GradeDisplay(frame: frame)

//: [Next](@next)
