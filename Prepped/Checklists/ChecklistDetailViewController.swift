/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/


import UIKit

class ChecklistDetailViewController: UITableViewController {
  
  let notesViewHeight: CGFloat = 128.0

  var checklist = checklists.first!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = checklist.title
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 64.0
  }
  
  // MARK: - Unwind segue methods
  
  @IBAction func cancelToChecklistDetailViewController(_ segue: UIStoryboardSegue) {
  }
  
  @IBAction func saveToChecklistDetailViewController(_ segue: UIStoryboardSegue) {
    if let controller = segue.source as? AddChecklistItemViewController,
      let item = controller.checklistItem {
        checklist.items.append(item)
        
        tableView.beginUpdates()
        let indexPath = IndexPath(row: checklist.items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .bottom)
        tableView.endUpdates()
    }
  }
}

// MARK: - UITableViewDelegate
extension ChecklistDetailViewController {
  override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    if let selected = tableView.indexPathForSelectedRow, selected == indexPath {
      self.tableView(tableView, didSelectRowAt: indexPath)
    }
  }
}

// MARK: - UITableViewDataSource
extension ChecklistDetailViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklist.items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath) as! ChecklistItemTableViewCell
    
    let checklistItem = checklist.items[indexPath.row]
    cell.checklistItem = checklistItem
    
    return cell
  }
}
