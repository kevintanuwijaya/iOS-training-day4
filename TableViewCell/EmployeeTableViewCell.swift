//
//  EmployeeTableViewCell.swift
//  MyProject2
//
//  Created by P090MMCTSE015 on 18/10/23.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(name: String, age: Int, salary: Int){
        nameLabel.text = name
        ageLabel.text = String(age)
        salaryLabel.text = "Rp." + String(salary)
    }
    
}
