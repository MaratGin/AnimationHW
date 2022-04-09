//
//  ViewController.swift
//  AnimationHW
//
//  Created by Marat Giniyatov on 08.04.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var hockeyImageView: UIImageView!
    @IBOutlet weak var basketballImageView: UIImageView!
    @IBOutlet weak var footballImageVIew: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var transitionView: UIView!


    // MARK: - variables
    var tapGesture: UITapGestureRecognizer!
    private var footBallAnimator: UIViewPropertyAnimator!
    private var basketBallAnimator: UIViewPropertyAnimator!
    private var hockeyPuckAnimator: UIViewPropertyAnimator!
    private var welcomeViewAnimator: UIViewPropertyAnimator!
    private var bigViewAnimator: UIViewPropertyAnimator!

    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.addSubview(welcomeLabel)
        welcomeView.bringSubviewToFront(welcomeLabel)
        makeInvisible()
        startFootBallAnimation()
        configureGesture()
        configureTransitionView()
    }
   
    // MARK: - gesture configuration
    
    func configureGesture() {
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
    }
    private func configureTransitionView() {
        transitionView.clipsToBounds = true
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Animation
    func makeInvisible() {
        welcomeView.alpha = 0
        hockeyImageView.alpha = 0
        basketballImageView.alpha = 0
        footballImageVIew.alpha = 0
        startButton.alpha = 0
    }
    
    func startFootBallAnimation() {
        footBallAnimator = UIViewPropertyAnimator(duration: 5, curve: .easeIn, animations: { [weak self] in
            self?.footballImageVIew.alpha = 1
            self?.footballImageVIew.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            let radians = CGFloat(180 * M_PI / 180)
            self?.footballImageVIew.transform = CGAffineTransform(rotationAngle: radians)
        })
        basketBallAnimator = UIViewPropertyAnimator(duration: 3, curve: .easeIn, animations: { [weak self] in
            self?.basketballImageView.alpha = 1
            self?.basketballImageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            let radians = CGFloat(180 * M_PI / 180)
            self?.basketballImageView.transform = CGAffineTransform(rotationAngle: radians)
        })
        hockeyPuckAnimator = UIViewPropertyAnimator(duration: 3, curve: .easeIn, animations: { [weak self] in
            self?.hockeyImageView.alpha = 1
            self?.hockeyImageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            let radians = CGFloat(180 * M_PI / 180)
            self?.hockeyImageView.transform = CGAffineTransform(rotationAngle: radians)
        })
        welcomeViewAnimator = UIViewPropertyAnimator(duration: 3, curve: .easeIn, animations: { [weak self] in
            self?.welcomeView.alpha = 1
            self?.welcomeLabel.textColor = .black
        })
        bigViewAnimator = UIViewPropertyAnimator(duration: 3, curve: .easeIn, animations: { [weak self] in
            self?.view.alpha = 1
            self?.view.backgroundColor = #colorLiteral(red: 0.778927505, green: 0.8881345391, blue: 0.9511142373, alpha: 1)
        })
    }
    
  
    // MARK: - Actions
    @objc func tapGestureAction() {
        print("1231313")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @IBAction func sliderDidChange(_ sender: UISlider) {
        self.footBallAnimator.fractionComplete = CGFloat(self.progressSlider.value)
        self.basketBallAnimator.fractionComplete = CGFloat(self.progressSlider.value)
        self.hockeyPuckAnimator.fractionComplete = CGFloat(self.progressSlider.value)
        self.welcomeViewAnimator.fractionComplete =
            CGFloat(self.progressSlider.value)
        self.bigViewAnimator.fractionComplete =
            CGFloat(self.progressSlider.value)
        
        if progressSlider.value == 1 {
            UIButton.animate(withDuration: 3, delay: 0, options: .curveLinear, animations: {
                self.startButton.backgroundColor = .systemTeal
                self.startButton.alpha = 1
                self.startButton.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                usleep(500000)
                self.startButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.startButton.layer.cornerRadius = 15
            } , completion: nil)
            
        }
    }
    }

// MARK: - Extension UIViewControllerTransitioningDelegate

extension StartViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromViewController = presenting as? StartViewController,
              let feedViewController = presented as? FeedViewController else {
                  return nil
              }
        return AnimatedTransitioning(fromViewController: fromViewController, feedViewController: feedViewController)
    }
    
}

// MARK: - Animaed Transitioning final class

final class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let fromViewController: StartViewController
    private let feedViewController: FeedViewController
    
     init(fromViewController: StartViewController, feedViewController: FeedViewController ) {
        self.fromViewController = fromViewController
        self.feedViewController = feedViewController
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = feedViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        guard let startViewController = fromViewController as? StartViewController else {
                  transitionContext.completeTransition(false)
                  return
              }
        toView.alpha = 0
        containerView.addSubview(toView)
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear) {
            startViewController.view.backgroundColor = .black
            toView.backgroundColor = .systemMint
            toView.alpha = 1
            startViewController.transitionView.transform =
            CGAffineTransform(scaleX: 15, y: 15)
        } completion: { _ in
            transitionContext.completeTransition(true)
            return
        }
    }
}


