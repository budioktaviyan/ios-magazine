import UIKit
import CoreText

class TextView: UIScrollView {
    
    func buildFrames(withAttrString attrString: NSAttributedString,
                     andImages images: [[String: Any]]) {
        isPagingEnabled = true
        let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        var pageView = UIView()
        var textPos = 0
        var columnIndex: CGFloat = 0
        var pageIndex: CGFloat = 0
        let settings = TextSettings()

        while textPos < attrString.length {
            
            if columnIndex.truncatingRemainder(dividingBy: settings.columnsPerPage) == 0 {
                columnIndex = 0
                pageView = UIView(frame: settings.pageRect.offsetBy(dx: pageIndex * bounds.width, dy: 0))
                addSubview(pageView)

                pageIndex += 1
                
                let columnXOrigin = pageView.frame.size.width / settings.columnsPerPage
                let columnOffset = columnIndex * columnXOrigin
                let columnFrame = settings.columnRect.offsetBy(dx: columnOffset, dy: 0)
                
                let path = CGMutablePath()
                path.addRect(CGRect(origin: .zero, size: columnFrame.size))
                let ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, nil)
                
                let column = ColumnView(frame: columnFrame, ctframe: ctframe)
                pageView.addSubview(column)
                
                let frameRange = CTFrameGetVisibleStringRange(ctframe)
                textPos += frameRange.length
                
                columnIndex += 1
            }
        }
        
        contentSize = CGSize(width: CGFloat(pageIndex) * bounds.size.width,
                             height: bounds.size.height)
    }
}
