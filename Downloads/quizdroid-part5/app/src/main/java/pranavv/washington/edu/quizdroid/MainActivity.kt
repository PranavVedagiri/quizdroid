package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.ArrayAdapter
import android.widget.ListView
import java.util.*


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        var quiz = QuizApp()
        val topics = arrayOf(quiz.getTopic(0).getTitle(), quiz.getTopic(1).getTitle(), quiz.getTopic(2).getTitle())
        val descriptions = arrayOf(quiz.getTopic(0).getLongDescription(), quiz.getTopic(1).getLongDescription(), quiz.getTopic(2).getLongDescription())

        val mapQuestions = hashMapOf(topics[0] to  arrayOf(quiz.getTopic(0).getQuestions()[0].getQuestion(), quiz.getTopic(0).getQuestions()[1].getQuestion())
                , topics[1] to arrayOf(quiz.getTopic(1).getQuestions()[0].getQuestion(), quiz.getTopic(0).getQuestions()[1].getQuestion()), topics[2] to arrayOf(quiz.getTopic(2).getQuestions()[0].getQuestion(), quiz.getTopic(0).getQuestions()[1].getQuestion()))

        val mapAnswers = hashMapOf(topics[0] to quiz.getTopic(0).getQuestions()[0].getAnswers() + quiz.getTopic(0).getQuestions()[1].getAnswers(),
                topics[1] to quiz.getTopic(1).getQuestions()[0].getAnswers() + quiz.getTopic(1).getQuestions()[1].getAnswers(),
                topics[2] to quiz.getTopic(2).getQuestions()[0].getAnswers() + quiz.getTopic(2).getQuestions()[1].getAnswers())

        val listView = findViewById<ListView>(R.id.listView) as ListView
        listView.adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, topics)

        listView.setOnItemClickListener { _, _, position, id ->
            val intent = Intent(this, topic::class.java).apply {
                putExtra("topic", topics[position])
                putExtra("description", descriptions[position])
                putExtra("questions", mapQuestions[topics[position]])
                putExtra("answers", mapAnswers[topics[position]])
            }
            startActivity(intent)
        }


    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        when(item?.itemId){
            R.id.preference -> {
                val intent = Intent(this, preferences_changer::class.java)
                startActivity(intent)
                return super.onOptionsItemSelected(item)
            }
            else -> return super.onOptionsItemSelected(item)

        }
    }

}
