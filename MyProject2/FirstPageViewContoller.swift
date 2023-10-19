//
//  FirstPageViewContoller.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import UIKit

class FirstPageViewContoller: UIViewController {

    @IBAction func toAPIBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toAPI", sender: nil)
    }
    
    @IBAction func toLocalStorage(_ sender: UIButton) {
        performSegue(withIdentifier: "toLocalStorage", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
