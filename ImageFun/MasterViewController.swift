//
//  MasterViewController.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ImagePickerControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var images = [ImageWithAttributes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let imagePickerController = storyboard.instantiateViewController(withIdentifier: "ImagePicker") as! ImagePickerController
        imagePickerController.setDelegate(self)
        self.present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let imageWithAttributes = self.images[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.imageWithAttributes = imageWithAttributes
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        guard let imageContainer = cell.imageContainer, let title = cell.title, let attributes = cell.attributes else {
            return cell
        }
        imageContainer.image = self.images[indexPath.row].image
        title.text = self.images[indexPath.row].title
        attributes.text = self.images[indexPath.row].attributes
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }

    func setImage(image: UIImage?) {
        guard let image = image else {
            return
        }
        
        let imageWithAttributes = ImageWithAttributes(image: image, title: "foo", attributes: "")
        self.images.append(imageWithAttributes)
        self.tableView.reloadData()
    }

}

