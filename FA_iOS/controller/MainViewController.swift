import UIKit

class MainViewController: UIViewController, TicTacToeDelegate {

    // MARK: IBOutlets
    @IBOutlet private var allGameButtons: [GameButton]!

    // MARK: Properties
    private var game: TicTacToe!
    private var currentPlayerString: String {
        return "\(game.player.name),\nit's your turn 🙂"
    }

    // MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        game = TicTacToe()
        game.delegate = self

        setUpViews()
    }

    // MARK: IBActions
    @IBAction func pressGameButton(sender button: GameButton) {
        button.isEnabled = false
        button.setTitle(game.player.rawValue, for: .normal)
        button.setTitleColor(game.player.color, for: .disabled)
        game.player(didChoose: (button.row, button.column))
    }

    @IBAction func pressRestartButton() {
        game.reset()
        setUpViews()
    }

    // MARK: Private Methods
    private func setUpViews() {
        allGameButtons.forEach{
            $0.isEnabled = true
            $0.setTitleColor(.black, for: .disabled)
            $0.setTitle("", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 90)
        }
        bottomLabel.text = currentPlayerString
    }

    // MARK: TicTacToeModelDelegate
    func continues(with nextPlayer: TicTacToe.Player) {
        bottomLabel.text = currentPlayerString
    }

    func over(winner: TicTacToe.Player?) {
        allGameButtons.forEach { $0.isEnabled = false }
        if let winner = winner {
            bottomLabel.text = "\(winner.name.capitalized),\nYOU WIN! 🎉"
        } else {
            bottomLabel.text = "DRAW! Play again?"
        }
    }
}
