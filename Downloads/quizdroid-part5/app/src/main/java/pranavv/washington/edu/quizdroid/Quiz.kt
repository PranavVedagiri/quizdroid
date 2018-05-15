package pranavv.washington.edu.quizdroid

class Quiz(question: String, answers: Array<String>, indexAnswer: Int){
    private val question = question
    private val answers = answers
    private val index = indexAnswer
    fun getQuestion(): String{
        return this.question
    }

    fun getAnswers(): Array<String>{
        return this.answers
    }

    fun getIndex(): Int{
        return this.index
    }
}