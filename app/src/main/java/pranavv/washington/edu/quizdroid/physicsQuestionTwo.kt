package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.Button
import android.widget.RadioButton
import android.widget.RadioGroup

class physicsQuestionTwo : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.physics_question2)

        val numQuestions = 2


        val twentyFive = findViewById<RadioButton>(R.id.twentyfive) as RadioButton

        val submitMathTwo = findViewById<Button>(R.id.submitMathTwo) as Button
        submitMathTwo.setEnabled(false)

        val mathGroup = findViewById<RadioGroup>(R.id.mathRdioGroup) as RadioGroup

        var selectedAnswer = ""
        var finalAnswer = twentyFive.getText().toString()
        var right = intent.extras.getInt("Correct")

        mathGroup?.setOnCheckedChangeListener{ group, checkedId ->
            selectedAnswer = findViewById<RadioButton>(checkedId).getText().toString()
            if(selectedAnswer.equals(finalAnswer)){
                right++
            }
            submitMathTwo.setEnabled(true)
            submitMathTwo.setOnClickListener{
                val intent = Intent(this, PhysicsAnswer::class.java)
                intent.putExtra("FinalAnswer", finalAnswer)
                intent.putExtra("Right", right)
                intent.putExtra("NumQuestions", numQuestions)
                intent.putExtra("SelectedAnswer", selectedAnswer)
                startActivity(intent)
            }
        }

    }
}