
import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}

class ProfileImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 1
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = (frame.width) / 2
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}


 struct Rounded {
   static func roundedImage(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = #colorLiteral(red: 0.5132408738, green: 0.8211410642, blue: 0.2199990749, alpha: 1)
    }
    
    static func roundedButton1(button: UIButton) {
        button.layer.cornerRadius = 8
        button.layer.shadowRadius = 3

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        button.layer.shadowOpacity = 0.4
    }
    
    static func roundedButton2(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2 
          button.layer.shadowRadius = 3

          button.layer.shadowColor = UIColor.black.cgColor
          button.layer.shadowOffset = CGSize(width: 0, height: 2.5)
          button.layer.shadowOpacity = 0.4
      }
    
    static func emptyDataWithImage(TabelView: UITableView , Image: UIImage ,View: UIView ,MessageText: String) {
            let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
            if TabelView.numberOfRows(inSection: 0) == 0 {
                errorView.tag = 100
                errorView.backgroundColor = .white
                let image = UIImageView(frame: CGRect(x: errorView.frame.width / 2 - 100 , y: errorView.frame.height / 2 - 100, width: 200 , height: 200))
                image.image = Image
                
                let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 100
                    , y: errorView.frame.height/2 + 100, width: 200, height: 25))
                message.text = MessageText
                message.textColor = .red
                message.textAlignment = .center
                message.font = UIFont(name: "Futura-Bold", size: 20)
                
                errorView.addSubview(image)
                errorView.addSubview(message)
                View.addSubview(errorView)
            }
            else{
                if let viewWithTag = View.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }
            }
        }
    
    
    static func emptyData(TabelView: UITableView ,View: UIView ,MessageText: String) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
        if TabelView.numberOfRows(inSection: 0) == 0 {
            errorView.tag = 100
            errorView.backgroundColor = .white
            
            
            let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 200
                , y: errorView.frame.height/2 , width: 400, height: 25))
            message.text = MessageText
            message.textColor = .darkGray
            message.textAlignment = .center
            message.font = UIFont(name: "Futura-Normal", size: 20)
            
        
            errorView.addSubview(message)
            View.addSubview(errorView)
        }
        else{
            if let viewWithTag = View.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
}
