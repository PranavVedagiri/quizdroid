package pranavv.washington.edu.quizdroid

import android.app.Application
import android.util.Log

class QuizApp :  Application(), TopicRepository {
    val trc = TopicRepoClass()
    override fun onCreate() {
        super.onCreate()
        Log.d("QuizApp", "QuizApp Created")
    }

    override fun getTopics(): Array<Top>{
        return trc.getTopics()
    }

    override fun getTopic(index: Int): Top {
        return trc.getTopics()[index]
    }

}
