//
//  MoodSelectionViewController.swift
//  Mandala
//
//  Created by Dirk on 8/20/18.
//  Copyright © 2018 Dirk. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {
	
	@IBOutlet var stackView: UIStackView!
	@IBOutlet var addMoodButton: UIButton!
	
	var moods: [Mood] = [] {
		didSet {
			moodButtons = moods.map { mood in
				let moodButton = UIButton()
				moodButton.setImage(mood.image, for: .normal)
				moodButton.imageView?.contentMode = .scaleAspectFit
				moodButton.adjustsImageWhenHighlighted = false
				moodButton.addTarget(self, action: #selector(moodButtonTapped(_:)), for: .touchUpInside)
				return moodButton
			}
			
			currentMood = moods.first
		}
	}
	
	var currentMood: Mood? {
		didSet {
			guard let currentMood = currentMood else {
				addMoodButton?.setTitle(nil, for: .normal)
				addMoodButton?.backgroundColor = nil
				return
			}
			
			addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
			addMoodButton?.backgroundColor = currentMood.color
		}
	}
	
	@objc func moodSelectionChanged(_ sender: UIButton) {
		guard let selectedIndex = moodButtons.index(of: sender) else {
			preconditionFailure("Unable to find the tapped button int he buttons array.")
		}
		
		currentMood = moods[selectedIndex]
	}
	
	var moodButtons: [UIButton] = [] {
		didSet {
			oldValue.forEach { $0.removeFromSuperview() }
			moodButtons.forEach { stackView.addArrangedSubview($0) }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
		
		addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
		
	}
	
}
