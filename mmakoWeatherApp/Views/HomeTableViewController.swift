//
//  HomeTableViewController.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    private var viewModel: HomeTempViewModel
    
    init(viewModel: HomeTempViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpNavigationItems()
        viewModel.weatherDayData = viewModel.getWeatherDay()
    }
    
    func setUpNavigationItems() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navigationBar.barTintColor = .white
        let navigationItem = UINavigationItem(title: "Extended Forecast")
        let rightBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.tintColor = .black
        navigationBar.items = [navigationItem]
        view.addSubview(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "MainTempTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTempTableViewCell")
        tableView.register(UINib(nibName: "CurrentTempTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentTempTableViewCell")
        tableView.register(UINib(nibName: "FutureCastTableViewCell", bundle: nil), forCellReuseIdentifier: "FutureCastTableViewCell")
        tableView.estimatedRowHeight = 260
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellForMainTemp(at: indexPath)
        case 1:
            return cellForCurrentCast(at: indexPath)
        case 2, 3,4,5,6,7:
            return cellForFutureCast(at: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Cells
extension HomeTableViewController {
    func cellForMainTemp(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTempTableViewCell",
                                                       for: indexPath) as? MainTempTableViewCell else { return UITableViewCell() }
        let backgroundImage = UIImage(named: "forest_sunny")
            
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleToFill
            cell.backgroundView = backgroundImageView
        cell.setup(currentMainTemp: viewModel.currentTemp,
                   currentMainDescription: viewModel.currentMood)
        cell.selectionStyle = .none
        return cell
    }
    
    func cellForCurrentCast(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentTempTableViewCell",
                                                       for: indexPath) as? CurrentTempTableViewCell else { return UITableViewCell() }
        cell.setup(minTemp: viewModel.minTemp,
                   minDescription: viewModel.minDegreesDescription,
                   currentTemp: viewModel.currentTemp,
                   currentTempDescription: viewModel.currentDescription,
                   maxTemp: viewModel.maxTemp,
                   maxDescription: viewModel.maxDegreesDescription)
        setCellBackground(with: "47AB2F", cell: cell)
        cell.selectionStyle = .none
        return cell
    }
    
    func cellForFutureCast(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FutureCastTableViewCell",
                                                       for: indexPath) as? FutureCastTableViewCell else { return UITableViewCell() }
        
        let dayStrings = Array(viewModel.weatherDayData.keys)
        let row = indexPath.row - 2
        if row < dayStrings.count {
            let dayString = dayStrings[row]
            let forecastData = viewModel.weatherDayData[dayString]
            cell.cellSetup(futureDay: dayString,
                           iconImage: UIImage(named: "partlysunny") ?? UIImage(),
                           tempDegrees: String(format: "%.0f", (forecastData?.main.temp ?? 0) - 273.15) + "\(viewModel.degreeSymbol)")
        } else {
            cell.textLabel?.text = "--"
        }
        setCellBackground(with: "47AB2F", cell: cell)
        cell.selectionStyle = .none
        return cell
    }
    
    private func setCellBackground(with hexColor: String, cell: UITableViewCell) {
        let backgroundColor = UIColor(hex: hexColor)
        cell.backgroundColor = backgroundColor
    }
    
    @objc private func doneButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexValue = hexValue.replacingOccurrences(of: "#", with: "")
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
