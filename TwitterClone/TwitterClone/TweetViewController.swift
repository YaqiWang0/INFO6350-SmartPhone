import UIKit
import Firebase
import Toast_Swift

class TweetViewController: UIViewController {

    @IBOutlet weak var txtTweet: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tweet_action(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        let userID = uid!
        
        let dbRef = Database.database().reference()
        
        guard let key = dbRef.child("Tweet").child(userID).childByAutoId().key else { return }
        
        let post = [
            "Massage" : txtTweet.text!,
            "Author" : Auth.auth().currentUser?.email,
            "DateTime" : ServerValue.timestamp()] as [String : Any]
        
        let childUpdates = ["/Tweets/\(userID)/\(key)" : post]
        dbRef.updateChildValues(childUpdates)
        
        self.view.makeToast("Your Tweet is posted", duration: 3.0, position: .top)
        self.navigationController?.popViewController(animated: true)
    }
}
