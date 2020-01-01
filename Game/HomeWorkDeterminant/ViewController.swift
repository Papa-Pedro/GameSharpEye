//
import UIKit

class ViewController: UIViewController {
    //Variables
    var currentValue = 0 //slidet = currentValue
    var targetValue = 0 //переменная случайного числа
    var score = 0 //количество очков
    var round = 0 //какой раунд идет
    @IBOutlet weak var slider: UISlider!//делаем slider Instance(видно в файле) переменной для всех
    //переменная является атрибутом Слайдера
    @IBOutlet weak var targetLabel: UILabel!//переменная доступ для зарандомленного значение
    @IBOutlet weak var scoredLabel: UILabel!//переменная доступ для общего результата
    @IBOutlet weak var roundLabel: UILabel! //доступ к ячейке Round
    
    override func viewDidLoad() { //входная
        super.viewDidLoad()
        currentValue = lroundf(slider.value) //говорим что начальное значание равно текущему значению ползунка
        startNewGame()
        updateLabels()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) { //функция для работы со слайдером
        currentValue = lroundf(slider.value) // ..Value(Int) = lround(Float) округление
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    @IBAction func showAlert() { //после нажатия на кнопку идет код:
        let difference = abs(currentValue - targetValue) //различие между полученным результатом и загаданным
        let title: String
        var points = 100 - difference
        if difference == 0 { //насколько хорошо попал
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += 50
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close"
        }
        score += points
        let message = "You scored \(points) points"+"\nYour make \(currentValue)" //сообщение после нажатий
        let alert = UIAlertController(title: title, message: message,  preferredStyle: .alert) //заголовок и сам massage
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound(); self.updateLabels()})//кнопка что бы перейти на ViewController и вызвать новый раунд
        alert.addAction(action)//соединим кнопку с окном
        present(alert, animated: true, completion: nil)//добавим действие перехода
    }
    
    func startNewRound() { //рандомим новое число ставим ползунок на середину
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100)) //генерация рандомного числа
        currentValue = 50 //начальное значение
        slider.value = Float(currentValue) //перестановка слайдера на начальное число
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() { //меняет имя строки
        targetLabel.text = String(targetValue)
        scoredLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

