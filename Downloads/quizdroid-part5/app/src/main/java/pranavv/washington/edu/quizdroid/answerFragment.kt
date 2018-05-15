package pranavv.washington.edu.quizdroid

import android.app.Fragment
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.TextView
import org.w3c.dom.Text


class answerFragment : Fragment() {


    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val inflate = inflater?.inflate(R.layout.fragment_answer, container, false) as View

        val yourAnswer = inflate.findViewById<TextView>(R.id.yourAnswer) as TextView
        val realAnswer = inflate.findViewById<TextView>(R.id.realAnswer) as TextView

        val totalCorrect = inflate.findViewById<TextView>(R.id.totalCorrect) as TextView
        val button = inflate.findViewById<Button>(R.id.nextButton) as Button

        var questions = arguments!!.getStringArray("questions")
        var correct = arguments!!.getInt("correct")
        var questionNum = arguments!!.getInt("questionNum")
        var total = arguments!!.getInt("total")
        var answers = arguments!!.getStringArray("answers")
        var starting = arguments!!.getInt("starting")
        var selectedAnswer = arguments!!.getString("selectedAnswer")
        var answer = arguments!!.getString("answer")

        yourAnswer.setText("Your Answer: " + selectedAnswer)
        realAnswer.setText("Real Answer: " + answer)

        totalCorrect.setText("You got " + correct + " out of " + total)

        if(questionNum == total){
            button.text = "Finish"
        }else{
            button.text = "Next"
        }

        button.setOnClickListener{
            if(questionNum != total){
                val transaction = fragmentManager.beginTransaction()
                val question = questionFragment()
                val bundle = Bundle()
                bundle.putStringArray("questions", questions)
                bundle.putInt("correct", correct)
                bundle.putInt("questionNum", questionNum)
                bundle.putInt("total", total)
                bundle.putStringArray("answers", answers)
                bundle.putInt("starting", starting)
                question.arguments = bundle
                transaction.replace(R.id.fragments, question).commit()
            }else{
                val intent = Intent(this.activity, MainActivity::class.java)
                startActivity(intent)
            }
        }

        return inflate
    }
}