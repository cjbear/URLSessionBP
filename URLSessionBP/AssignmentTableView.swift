//
//  AssignmentTableView.swift
//  
//
//  Created by Christopher Johnson on 1/17/19.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var assignmentDueAtLabel: UILabel!

}

class AssignmentTableView: UITableViewController {
    
     var assignments = [Assignment]() // array into which assignments are stored after JSON is parsed

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Configure table and display data

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return assignments.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentTableViewCell

        // Configure the cell...
        
        let assignment = assignments[indexPath.row]
        cell.assignmentNameLabel?.text = assignment.name
        cell.assignmentDueAtLabel?.text = String(assignment.dueAt!)

        return cell
    }
    
    //MARK: Configure URLSession
    
    // 1. assign canvasAPI variables
    let canvas_api_url: String = "https://canvas.instructure.com/api/v1/"
    let course_id: String = "12345"
    let canvas_api_key: String = "7~pMe69XczZkRi2anWMxItDgHpAeC0HnHvb0lZlAghSoxu5gS1GdmEjsn98c8Waf7C"
    
    
    // 2. configure session and task
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask:URLSessionDataTask?
    
    
    // MARK: Use APIManager to get the assignment data
    
    func getAssignmentData(with url:URL) {
        
        let getURL = URL(string: canvas_api_url + course_id + canvas_api_key)
        let urlRequest = URLRequest(url: getURL!)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            // check for errors
            guard let data  = data else {
                print("returned error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let assignmentData = try decoder.decode([Assignment].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    
                    print(assignmentData)
                    self.assignments = assignmentData
                    self.tableView?.reloadData()
                }
                
            } catch let error as NSError {
                print(error)
            }
        })
        
        self.dataTask?.resume()
    }
    
    //MARK: Save to database




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
