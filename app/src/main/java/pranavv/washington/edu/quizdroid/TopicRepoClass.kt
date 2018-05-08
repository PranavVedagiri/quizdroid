package pranavv.washington.edu.quizdroid

class TopicRepoClass: TopicRepository{
    override fun getTopics(): Array<Top> {
        var mathOne = Quiz("What is 2 + 2?", arrayOf("Expression", "Window", "Quick Maths", "4"), 0)
        var mathTwo = Quiz("What is the square root of 625?", arrayOf("25", "Window", "165", "15"), 0)
        var math = Top("Math", "math questions", "These are some math questions", arrayOf(mathOne, mathTwo))

        var physicsOne = Quiz("Which branch of Einstein's Theory of Relativity deals with Gravity?", arrayOf("General Relativity", "Relative Relativity", "Relativity of Gravity", "Spatial Relativity"), 0)
        var physicsTwo = Quiz("What physics law describes how light acts in a prism?", arrayOf("Snell's Law", "Stoke's Law", "Beer's Law", "Newton's Law"), 0)
        var physics = Top("Physics", "physics questions", "These are some physics questions", arrayOf(physicsOne, physicsTwo))

        var marvelOne = Quiz("Which movie was the first to be released in the MCU?", arrayOf("Iron Man", "Thor", "Bee Movie", "The Hulk"), 0)
        var marvelTwo = Quiz("Which one of these marvel charaacters is not a part of S.H.I.E.L.D?", arrayOf("Wade Wilson", "Natasha Romanov", "Nick Fury", "Hawkeye"), 0)
        var marvel = Top("Marvel", "marvel questions", "These are some marvel questions", arrayOf(marvelOne, marvelTwo))

        return arrayOf(math, physics, marvel)
    }

    override fun getTopic(index: Int): Top {
        return getTopics()[index]
    }
}