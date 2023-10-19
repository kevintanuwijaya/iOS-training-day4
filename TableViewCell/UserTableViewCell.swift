//
//  UserTableViewCell.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 19/10/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(id: Int, name: String, salary: Int){
        detailLabel.text = String(id) + " . " + name
        salaryLabel.text = "IDR. " + String(salary)
        return
    }
    
}
