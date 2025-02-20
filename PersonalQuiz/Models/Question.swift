//
//  Question.swift
//  PersonalQuiz
//
//  Created by Ast on 11.02.2025.
//

struct Question {
    let title: String
    let answers: [Answer]
    let category: Category
    
    static let questions: [Question] = [
        Question(
            title: "Какую пищу вы предпочитаете?",
            answers: [
                Answer(title: "Стейк", animal: .dog),
                Answer(title: "Рыба", animal: .cat),
                Answer(title: "Морковь", animal: .rabbit),
                Answer(title: "Кукуруза", animal: .turtle)
            ],
            category: .single
        ),
        Question(
            title: "Что вам нравится больше?",
            answers: [
                Answer(title: "Плавать", animal: .turtle),
                Answer(title: "Спать", animal: .cat),
                Answer(title: "Обниматься", animal: .rabbit),
                Answer(title: "Есть", animal: .dog)
            ],
            category: .multiple
        ),
        Question(
            title: "Любите ли вы поездки на машине?",
            answers: [
                Answer(title: "Ненавижу", animal: .rabbit),
                Answer(title: "Нервничаю", animal: .cat),
                Answer(title: "Не замечаю", animal: .turtle),
                Answer(title: "Обожаю", animal: .dog)
            ],
            category: .ranged
        )
    ]
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Category {
    case single
    case multiple
    case ranged
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "😺"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}
