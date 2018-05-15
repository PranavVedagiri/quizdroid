package pranavv.washington.edu.quizdroid

class Top(title: String, long: String, questions: ArrayList<Quiz>){
    private val title = title
    private val long = long
    private val questions = questions

    fun getTitle():String{
        return this.title
    }

    fun getLongDescription():String {
        return this.long
    }

    fun getQuestions() : ArrayList<Quiz> {
        return this.questions
    }
}