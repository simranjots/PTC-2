//
//  AboutAuthorViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-05.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class AboutAuthorViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var authorImage: UIImageView!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var aboutAuthorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorImage.image = UIImage(named: "teresa")
        authorImage.layer.cornerRadius = 70
        authorImage.layer.borderColor = Utilities.brandRedColor.cgColor
        authorImage.layer.borderWidth = 2
        authorNameLabel.text = "Teresa B. Easler"
        //aboutAuthorLabel.text = ""
    }
}

//For as far back as she can remember Teresa has always been passionate about the power of good communication. In fact, it was an incident that happened in her formative years that truly shaped the trajectory of her life. When Teresa was in grade school in the late 1950s, she was punished for talking out of turn in class (I know we were shocked too!). The teacher decided that her “punishment” was to be seated next to the only African American child in the class. Teresa certainly didn’t see this as much of a punishment for herself, but even at that young age she was acutely aware of how humiliating this must have been for the other child. That incident was the beginning of her commitment to seeing things from other peoples’ perspectives, and the power of both verbal, and non-verbal communication.  Whether guiding business leaders to reach new heights, coaching individuals to increase results by bettering their presentation skills or mentoring women of all ages, Teresa works with joyful determination to ensure her clients leave their time together challenged, and in an enhanced position to reach their goals. Teresa has found there are certain universal principles that work consistently. “When we communicate from the best of who we are,” she says, “from what’s most important to us, we inspire ourselves and we can inspire others. There’s communication, not just data exchange.”  When we look at the depth and diversity of Teresa’s entrepreneurial experiences, we often joke that it appears she has had many incarnations. She has done everything from running a successful gourmet cheesecake business from her home (yes, she was head baker too!), to running a company that offered high-end video production services to corporate clients. No matter what the business she quickly recognized that her success was rooted in good communication.  After many years of consulting with her corporate clients, Teresa realized companies needed help with their messaging, marketing and overall communication strategy, so she formed Connect To The Core Inc. because she truly believes at the core of all success is great communication, and at the core of all great communication is connection.  It is over 35 years since she started, and Teresa has helped thousands of individuals and hundreds of companies reach their goals. She is now in her element, creating original solutions to complex issues for her clients to become their best selves and achieve remarkable results.  Teresa was born and raised in Michigan and lived throughout the US for many years. She currently splits her time between her home in Toronto, Canada and her farm in Northern Michigan.
