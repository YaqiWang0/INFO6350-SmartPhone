import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblImage: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func takePic(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = pickedImage
            identifyImage()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func identifyImage() {
        guard let ciImage = CIImage(image: imgView.image!) else { return }
        guard let model = try? VNCoreMLModel(for: FoodImageClassifier().model) else { return }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            let result = request.results!
            let topResult = result.first
            self.lblImage.text = (topResult! as AnyObject).identifier
            print(result)
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try handler.perform([request])
        } catch {
            print("error in performing image recognition \(error.localizedDescription)")
        }
    }
    
}

