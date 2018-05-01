package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.ArrayAdapter
import android.widget.ListView


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val topics = arrayOf("Math", "Physics", "Marvel Super Heroes")
        val str = "Thiz quiz will test you on various concepts of "
        val descriptions = arrayOf(str + "math.", str + "physics.", str + "marvel super heroes.")

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

        val mapQuestions = hashMapOf("Math" to mathQuestions, "Physics" to physicsQuestions, "Marvel Super Heroes" to marvelQuestions)
        val mapAnswers = hashMapOf("Math" to mathAnswers, "Physics" to physicsAnswers, "Marvel Super Heroes" to marvelAnswers)

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
