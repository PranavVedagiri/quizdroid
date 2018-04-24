package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.RadioButton
import android.widget.RadioGroup

class marvelQuestionOne : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.marvel_question_one)

        val numQuestions = 1


        val expression = findViewById<RadioButton>(R.id.expression) as RadioButton

        val submitMathOne = findViewById<Button>(R.id.submitMathOne) as Button
        submitMathOne.setEnabled(false)

        val mathGroup = findViewById<RadioGroup>(R.id.mathRdioGroup) as RadioGroup

        var selectedAnswer = ""
        var finalAnswer = expression.getText().toString()
        var right = 0

        mathGroup?.setOnCheckedChangeListener{ group, checkedId ->
            selectedAnswer = findViewById<RadioButton>(checkedId).getText().toString()
            if(selectedAnswer == finalAnswer){
                right++
            }
            submitMathOne.setEnabled(true)
            submitMathOne.setOnClickListener{
                val intent = Intent(this, MarvelAnswer::class.java)
                intent.putExtra("FinalAnswer", finalAnswer)
                intent.putExtra("NumQuestions", numQuestions)
                intent.putExtra("SelectedAnswer", selectedAnswer)
                startActivity(intent)
            }
        }

    }
}