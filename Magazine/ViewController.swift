import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let file = Bundle.main.path(forResource: "zombies", ofType: "txt") else { return }
        do {
            let text = try String(contentsOfFile: file, encoding: .utf8)
            let parser = MarkupParser()
            parser.parseMarkup(text)

            (view as? TextView)?.importAttrString(parser.attrString)
        } catch _ {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
