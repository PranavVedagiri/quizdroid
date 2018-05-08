package pranavv.washington.edu.quizdroid

class Top(title: String, short: String, long: String, questions: Array<Quiz>){
    private val title = title
    private val short = short
    private val long = long
    private val questions = questions

    fun getTitle():String{
        return this.title
    }

    fun getShortDescription():String {
        return this.short
    }

    fun getLongDescription():String {
        return this.long
    }

    fun getQuestions() : Array<Quiz> {
        return this.questions
    }
}