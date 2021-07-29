//
//  IBDesignable.swift
//  ZeZign T-shirt
//
//  Created by Virtual Dusk  on 6/12/17.
//  Copyright © 2017 Endive Software. All rights reserved.
//


import UIKit
import QuartzCore
@IBDesignable
class customLabel: UILabel {
    @IBInspectable var cornerRadius : CGFloat = 0  {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var backgroundcolor: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = backgroundcolor
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience init() {
        
        
        self.init(frame:CGRect.zero)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        configure()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    func setup() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.0
        layer.cornerRadius = 0.0
        backgroundColor = UIColor.black
    }
    
    func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        backgroundColor = backgroundcolor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
class MyTabBar: UITabBar {
    private var shapeLayer: CALayer?
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    func createPath() -> CGPath {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough

        path.addCurve(to: CGPoint(x: centerWidth, y: height),
        controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))

        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 0  {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var backgroundcolor: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = backgroundcolor
        }
    }
    
    @IBInspectable var titleColor: UIColor = UIColor.black{
        didSet {
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
            self.clipsToBounds = false
            layer.shadowOpacity = 0.60
            layer.shadowRadius  = 5.0
            layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
    
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience init() {
        
        
        self.init(frame:CGRect.zero)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        configure()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    func setup() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.0
        layer.cornerRadius = 0.0
        backgroundColor = UIColor.black
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        backgroundColor = backgroundcolor
        self.setTitleColor(titleColor, for: .normal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

@IBDesignable
public class CustomTextField: UITextField {
    
    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// Sets the placeholder color
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    public override var placeholder: String? {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    /// Sets left margin
    @IBInspectable public var leftMargin: CGFloat = 10.0 {
        didSet {
            setMargins()
        }
    }
    
    /// Sets right margin
    @IBInspectable public var rightMargin: CGFloat = 10.0 {
        didSet {
            setMargins()
        }
    }
    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        applyStyles()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyles()
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateAccessoryViewFrame()
    }
    
    // MARK: - Styles
    private func applyStyles() {
        setMargins()
    }
    
    // MARK: - Margins
    private var leftAcessoryView = UIView()
    private var rightAcessoryView = UIView()
    private func setMargins() {
        // Left Margin
        leftView = nil
        leftViewMode = .never
        if leftMargin > 0 {
            if nil == leftView {
                leftAcessoryView.backgroundColor = .clear
                leftView = leftAcessoryView
                leftViewMode = .always
            }
        }
        updateAccessoryViewFrame()
        
        // Right Margin
        rightView = nil
        rightViewMode = .never
        if rightMargin > 0 {
            if nil == rightView {
                rightAcessoryView.backgroundColor = .clear
                rightView = rightAcessoryView
                rightViewMode = .always
            }
            updateAccessoryViewFrame()
        }
    }
    
    private func updateAccessoryViewFrame() {
        // Left View Frame
        var leftRect = bounds
        leftRect.size.width = leftMargin
        leftAcessoryView.frame = leftRect
        // Right View Frame
        var rightRect = bounds
        rightRect.size.width = rightMargin
        rightAcessoryView.frame = rightRect
    }
    
}


@IBDesignable
public class CustomView: UIView {
    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
            self.clipsToBounds = false
            //layer.cornerRadius = 14
            layer.shadowOpacity = 0.25
            layer.shadowRadius  = 5.0
            layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
}


@IBDesignable
public class CustomLabel: UILabel {
    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


@IBDesignable
public class CustomImageView: UIImageView {
    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
