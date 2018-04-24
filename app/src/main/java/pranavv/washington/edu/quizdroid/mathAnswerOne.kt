package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView
import org.w3c.dom.Text

class mathAnswerOne : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.math_answer)

        val yourAnswer = findViewById<TextView>(R.id.yourAnswer)
        val response = intent.extras.getString("SelectedAnswer")
        yourAnswer.text = "Your Answer: " + response

        val realAnswer = findViewById<TextView>(R.id.realAnswer)
        val finalAnswer = intent.extras.getString("FinalAnswer")
        realAnswer.text = "Right Answer: " + finalAnswer

        val totalCorrect = findViewById<TextView>(R.id.totalCorrect)
        val numQuestions = intent.extras.getInt("NumQuestions")

        var right = intent.extras.getInt("Right")


        val nextButton = findViewById<Button>(R.id.nextButton)
        if(numQuestions == 1){
            nextButton.setText("Next")
            nextButton.setOnClickListener{
                val intent = Intent(this, MathQuestionTwo::class.java)
                intent.putExtra("Correct", right)
                startActivity(intent)
            }
        }else{
            nextButton.setText("Finish")
            nextButton.setOnClickListener {
                val intent = Intent(this, MainActivity::class.java)
                startActivity(intent)
            }
        }
        totalCorrect.text = "You got " + right + " out of " + numQuestions + " right."


    }
}