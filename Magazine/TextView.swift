import UIKit
import CoreText

class TextView: UIView {
    
    var attrString: NSAttributedString!

    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        let path = CGMutablePath()
        path.addRect(bounds)

        let framesetter = CTFramesetterCreateWithAttributedString(self.attrString as CFAttributedString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attrString.length), path, nil)
        CTFrameDraw(frame, context)
    }
    
    // Internal
    func importAttrString(_ attrString: NSAttributedString) {
        self.attrString = attrString
    }
}
