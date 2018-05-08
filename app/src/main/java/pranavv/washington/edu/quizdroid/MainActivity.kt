package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
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

        val mathQuestions = arrayOf("What is 2 + 2?", "What is the square root of 625?")
        val mathAnswers = arrayOf("Expression", "Window", "Quick Maths", "4", "25", "Window", "165", "15")
        val m_a_one = "Expression"
        val m_a_two = "25"

        val physicsQuestions = arrayOf("Which branch of Einstein's Theory of Relativity deals with Gravity?", "What physics law describes how light acts in a prism?")
        val physicsAnswers = arrayOf("General Relativity", "Relative Relativity", "Relativity of Gravity", "Spatial Relativity", "Snell's Law", "Stoke's Law", "Beer's Law", "Newton's Law")
        val p_a_one = "General Relativity"
        val p_a_two = "Snell's Law"

        val marvelQuestions = arrayOf("Which movie was the first to be released in the MCU", "Which one of these marvel charaacters is not a part of S.H.I.E.L.D")
        val mv_a_one = "Iron Man"
        val marvelAnswers = arrayOf("Iron Man", "Thor", "Bee Movie", "The Hulk", "Wade Wilson", "Natasha Romanov", "Nick Fury", "Hawkeye")
        val mv_a_two = "Wade Wilson"

        val mapQuestions = hashMapOf(topics[0] to arrayOf(quiz.getTopic(0).getQuestions()[0].getQuestion(), quiz.getTopic(0).getQuestions()[1].getQuestion())
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

}
