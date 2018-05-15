package pranavv.washington.edu.quizdroid
import android.os.AsyncTask
import android.os.Environment
import android.util.JsonReader
import android.util.Log
import org.json.JSONArray
import org.json.JSONObject
import java.io.*
import java.net.HttpURLConnection
import java.net.MalformedURLException
import java.net.URL

class TopicRepoClass: TopicRepository, AsyncTask<String, String, String> {

    var url = ""
    var topic = ArrayList<Top>()

    constructor(){
        url = "https://raw.githubusercontent.com/PranavVedagiri/quizdroid_json/master/quizdroid.json"
        execute(url).get()
    }

    override fun doInBackground(vararg params: String?): String {
        Log.d("Tag", "Im here")
        val connect = URL(url).openConnection() as HttpURLConnection
        var information = ""
        val file = File(Environment.getExternalStorageDirectory().toString() + "questions.json")
        try {
            information = BufferedInputStream(connect.inputStream).use {
                it.reader().use { reader ->
                    reader.readText()
                }
            }
            Log.d("Tag", "Inside try block")
        } finally {
            connect.disconnect()
        }

        val info = JSONArray(information)
        Log.d("Tag", info.toString())

        for (i in 0..info.length() - 1) {
            val subject = info.getJSONObject(i)
            val title = subject.getString("title")
            Log.d("Tag", title)

            val description = subject.getString("desc")
            Log.d("Tag", description)

            val questions = subject.getJSONArray("questions")
            val qs = ArrayList<Quiz>()
            for (j in 0..questions.length() - 1) {
                val questionJSON = questions.getJSONObject(j)
                val qText = questionJSON.getString("text")
                val answer = questionJSON.getInt("answer")
                val answers = questionJSON.getJSONArray("answers")
                val listAnswers = Array(answers.length()) { "" }
                for (k in 0..answers.length() - 1) {
                    listAnswers[k] = answers[k].toString()
                }
                qs.add(Quiz(qText, listAnswers, answer - 1))
            }

            topic.add(Top(title, description, qs))
        }

        return information
    }

    override fun getTopics(): ArrayList<Top> {
        return topic
    }

    override fun getTopic(index: Int): Top {
        return getTopics().get(index)
    }
}