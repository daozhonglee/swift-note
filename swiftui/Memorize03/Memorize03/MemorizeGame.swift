//
//  MemorizeGame.swift
//  Memorize03
//
//  Created by shanquan on 2024/12/7.
//
// 让整个记忆游戏都是泛型的
struct MemoryGame<CardContent>{
    //private 让 cards 只能在这个结构体中访问，否则其他类可以直接修改 cards
    //所有的行为都应该通过这个结构体的方法来实现
    // private(set) 会将 set 方法设置为私有, get 依然是公有的
    private(set) var cards: Array<Card>

    //如果要初始化
    init(numberofPairsOfCards:Int){
        cards = Array<Card>()
    }

    func chooseCard(_ card:Card){

    }

    //声明一个泛型类型的 Card，会使用 CardContent 作为内容
    struct Card{
        var isFaceUp:Bool = true
        var isMatched:Bool = false
        var content: CardContent
    }
}
