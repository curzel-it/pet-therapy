//
// Pet Therapy.
//

import AppKit
import Combine
import Schwifty
import Squanch

open class AnimatedSprite: Capability, ObservableObject {
    
    public let id: String
    
    @Published public private(set) var animation: ImageAnimator = .none
    
    private var lastFrameBeforeAnimations: CGRect
    private var lastState: EntityState = .drag
    private var stateCanc: AnyCancellable!
    
    public required init(with subject: Entity) {
        self.id = "\(subject.id)-Sprite"
        self.lastFrameBeforeAnimations = subject.frame
        super.init(with: subject)
        
        stateCanc = subject.$state.sink { newState in
            Task { @MainActor in
                self.lastState = newState
                self.updateSprite()
            }
        }
    }
    
    @MainActor
    private func updateSprite() {
        guard let subject = subject else { return }
        guard let path = subject.animationPath(for: lastState) else { return }
        guard path != animation.baseName else { return }
        printDebug(id, "Loaded", path)
        
        animation.invalidate()
        
        if case .animation(let anim, let requiredLoops) = lastState {
            subject.set(frame: anim.frame(for: subject))
            subject.movement?.isEnabled = false
            
            animation = ImageAnimator(path) { completedLoops in
                guard requiredLoops == completedLoops else { return }
                subject.movement?.isEnabled = true
                subject.set(state: .move)
                subject.set(frame: self.lastFrameBeforeAnimations)
            }
        } else {
            animation = ImageAnimator(path) { _ in }
        }
    }
    
    open override func update(with collisions: Collisions, after time: TimeInterval) {
        guard isEnabled else { return }
        guard let subject = subject else { return }
        
        if let next = animation.nextFrame(after: time) {
            subject.sprite = next
        }
        if case .animation = subject.state {
            // ...
        } else {
            lastFrameBeforeAnimations = subject.frame
        }
    }
    
    open override func uninstall() {
        subject?.sprite = nil
        super.uninstall()
        animation = .none
        stateCanc?.cancel()
        stateCanc = nil
    }
}

extension Entity {
    
    public var animation: AnimatedSprite? { capability(for: AnimatedSprite.self) }
    
    public var isDrawable: Bool { animation != nil }
}