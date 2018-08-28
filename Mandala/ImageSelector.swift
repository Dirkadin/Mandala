//
//  ImageSelector.swift
//  Mandala
//
//  Created by Dirk on 8/24/18.
//  Copyright © 2018 Dirk. All rights reserved.
//

import UIKit

class ImageSelector: UIControl {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViewHierarchy()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configureViewHierarchy()
	}
	
	private let selectedStackview: UIStackView = {
		let stackView = UIStackView()
		
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		stackView.spacing = 12.0
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	var selectedIndex = 0
	
	private var imageButtons: [UIButton] = [] {
		didSet {
			oldValue.forEach { $0.removeFromSuperview() }
			imageButtons.forEach { selectedStackview.addArrangedSubview($0) }
		}
	}
	
	var images: [UIImage] = [] {
		didSet {
			imageButtons = images.map { image in
				let imageButton = UIButton()
				imageButton.setImage(image, for: .normal)
				imageButton.imageView?.contentMode = .scaleAspectFit
				imageButton.adjustsImageWhenHighlighted = false
				imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
				
				return imageButton
			}
		}
	}
	
	@objc private func imageButtonTapped(_ sender: UIButton) {
		guard let buttonIndex = imageButtons.index(of: sender) else {
			preconditionFailure("The button and images are not parallel.")
		}
		
		selectedIndex = buttonIndex
		sendActions(for: .valueChanged) // Says the value has changed to make the didSet fire?
	}
	
	private func configureViewHierarchy() {
		addSubview(selectedStackview)
		
		NSLayoutConstraint.activate([
			selectedStackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
			selectedStackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
			selectedStackview.centerYAnchor.constraint(equalTo: centerYAnchor),
			selectedStackview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
		])
	}
}
